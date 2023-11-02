//
//  HomePresentation.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import UIKit
import MVVMInterface
import DesignSystem
import SnapKit
import RxSwift
import RxCocoa
import AVFoundation

public final class HomeViewController: UIViewController, View {
    
    // MARK: - Views
    
    private lazy var cameraContainerView = UIView()
    
    private lazy var shotButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 45
        return button
    }()
    
    private lazy var albumButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()
    
    // MARK: - Camera Property
    
    private var previewLayer = AVCaptureVideoPreviewLayer()
    private var captureSession = AVCaptureSession()
    private var output = AVCaptureVideoDataOutput()
    private var camera: AVCaptureDevice?
    private var input: AVCaptureInput?
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel?
    
    private var isCaptureSessionSetup = false
    private var isPreviewSetup = false
    private var takePicture = false
    private var usesFrontCamera = false
    
    private let sessionQueue = DispatchQueue(
        label: "CaptureHelperQueue",
        qos: .background
    )
    
    // MARK: - Initializer
    
    public init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel // TODO: DIContainer 사용
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupCaptureSession()
        bind(to: viewModel ?? .init())
    }
    
    // MARK: - Function
    
    public func bind(to viewModel: HomeViewModel) {
        print("바인딩 후 코디네이터로 액션 전달되는 지 확인")
        viewModel.temporaryCallCoordinatorActionIndirectly()
        
        switchCameraButton
            .rx
            .tap
            .do(onNext: { [weak self] in
                self?.usesFrontCamera.toggle()
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { owner, _ in
                owner.flipCamera()
                owner.isCaptureSessionSetup = false
            })
            .disposed(by: disposeBag)
        
        albumButton
            .rx
            .tap
            .asDriver()
            .throttle(.milliseconds(3))
            .drive(with: self, onNext: { owner, _ in
                owner.present(owner.picker, animated: true)
            })
            .disposed(by: disposeBag)
        
        shotButton
            .rx
            .tap
            .asDriver()
            .throttle(.milliseconds(3))
            .drive(with: self, onNext: { owner, _ in
                owner.takePicture = true
            })
            .disposed(by: disposeBag)
    }

    private func setupCaptureSession() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo
        captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            
            if !self.isCaptureSessionSetup { self.setupInput() }
            
            self.startCamera()
        }
        
        setupOutput()
        captureSession.commitConfiguration()
        isCaptureSessionSetup = true
    }
    
    private func setupInput() {
        let cameraPosition: AVCaptureDevice.Position = usesFrontCamera ? .front : .back

        guard let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: cameraPosition
        ) else {
            fatalError("no camera")
        }
       
        guard let cameraInput = try? AVCaptureDeviceInput(device: device) else {
            fatalError("could not create input device")
        }
        
        guard captureSession.canAddInput(cameraInput) else {
            fatalError("could not add camera input to capture session")
        }
        
        captureSession.addInput(cameraInput)
    }
    
    private func setupOutput() {
        guard captureSession.canAddOutput(output) else {
            fatalError("could not add video output")
        }
        
        captureSession.addOutput(output)
        output.connections.first?.videoOrientation = .portrait
    }
    
    private func startCamera() {
        if !captureSession.isRunning {
            sessionQueue.async { [weak self] in
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                
                switch status {
                case .notDetermined, .restricted, .denied:
                    self?.captureSession.stopRunning()
                    
                case .authorized:
                    self?.tryToSetupPreview()
                    self?.captureSession.startRunning()
                default:
                    fatalError("unknown default reached. Check code.")
                }
            }
        }
    }
    
    private func tryToSetupPreview() {
        if !isPreviewSetup {
            setupPreview()
            isPreviewSetup = true
        }
    }
    
    private func setupPreview() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.previewLayer.frame = self.cameraContainerView.bounds
            self.cameraContainerView.layer.addSublayer(self.previewLayer)
        }
    }
    
    private func flipCamera() {
        guard let input else { return }
        
        captureSession.beginConfiguration()
        captureSession.removeInput(input)
        setupInput()
        captureSession.commitConfiguration()
    }
    
    private func shoot() {

    }

    private func stopCamera() {
        guard captureSession.isRunning else { return }
        
        sessionQueue.async { [weak self] in
            guard let self else { return }
            self.captureSession.stopRunning()
        }
    }

}

// MARK: - configure UI

extension HomeViewController {
    
    private func configureUI() {
        view.backgroundColor = .lightGray
        
        view.addSubview(cameraContainerView)
        view.addSubview(shotButton)
        view.addSubview(albumButton)
        view.addSubview(switchCameraButton)

        cameraContainerView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.equalTo(shotButton.snp.top).offset(-40)
        }
        
        shotButton.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
        
        albumButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.centerY.equalTo(shotButton)
            $0.right.equalTo(shotButton.snp.left).offset(-40)
        }
        
        switchCameraButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.centerY.equalTo(shotButton)
            $0.left.equalTo(shotButton.snp.right).offset(40)
        }
    }
    
}
