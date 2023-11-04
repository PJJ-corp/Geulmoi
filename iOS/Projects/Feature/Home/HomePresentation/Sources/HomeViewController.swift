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
import Photos

public final class HomeViewController: UIViewController, View {
    
    // MARK: - Views
    
    private lazy var cameraContainerView = UIView()
    
    private lazy var shotButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .geulmoiKhaki
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowOffset = .init(width: 0, height: 0)
        button.layer.borderWidth = 10
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.2
        button.layer.cornerRadius = 45
        return button
    }()
    
    private lazy var albumButton: UIButton = {
        let button = UIButton()
        button.setImage(.album, for: .normal)
        button.backgroundColor = .geulmoiLightBrown
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(.change, for: .normal)
        button.backgroundColor = .geulmoiLightBrown
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
    private var photoSettings = AVCapturePhotoSettings()
    private var captureSession = AVCaptureSession()
    private var output = AVCapturePhotoOutput()
    private var camera: AVCaptureDevice?
    private var input: AVCaptureInput?
    
    // MARK: - Property
    
    private var viewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    private var isCaptureSessionSetup = false
    private var isPreviewSetup = false
    private var takePicture = false
    private var usesFrontCamera = false
    
    private let sessionQueue = DispatchQueue.global(qos: .background)
    
    // MARK: - Initializer

    public init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupCaptureSession()
    }
    
    // MARK: - Function
    
    public func bind(to viewModel: HomeViewModel) {
        
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
                owner.shoot()
            })
            .disposed(by: disposeBag)
    }
    
    private func viewBind() {
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
                owner.shoot()
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
        
        input = cameraInput
        
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
    
    private func photoCaptureSettings() -> AVCapturePhotoSettings {
        var settings = AVCapturePhotoSettings()
        settings.isHighResolutionPhotoEnabled = true
        
        settings = output.availablePhotoCodecTypes.contains(.hevc) ?
        AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc]) :
        AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                               
        return settings
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
        let settings = photoCaptureSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    private func passPhotoToNextVC(_ photo: AVCapturePhoto) {
        guard let data = photo.fileDataRepresentation() else { return }
        
        viewModel?.input.photoData.accept(data)
    }
    
    
    private func setPhotoLibraryAuthAlert() {
        let alert = UIAlertController(
            title: "사진 접근을 허용해주세요.",
            message: "허용 이후 사진을 저장할 수 있습니다.",
            preferredStyle: .alert
        )

        let getAuthAction = UIAlertAction(
            title: "설정으로 이동",
            style: .default,
            handler: { UIAlertAction in
                guard let appSettings = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        })

        alert.addAction(getAuthAction)
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - AVCapturePhotoCaptureDelegate

extension HomeViewController: AVCapturePhotoCaptureDelegate {
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else { return }
        
        PHPhotoLibrary.requestAuthorization ({ [weak self] status in
            switch status{
            case .authorized:
                self?.passPhotoToNextVC(photo)
            default:
                self?.setPhotoLibraryAuthAlert()
            }
        })
    }
        
}


// MARK: - configure UI

extension HomeViewController {
    
    private func configureUI() {
        view.backgroundColor = .geulmoiIvory
        
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
