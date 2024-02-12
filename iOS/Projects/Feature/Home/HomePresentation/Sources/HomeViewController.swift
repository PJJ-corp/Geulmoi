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

public final class HomeViewController: UIViewController, View {
    
    // MARK: - Views
    
    private let cameraContainerView = UIView()
    
    private lazy var shotButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .geulmoiKhaki
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 10
        button.layer.shadowOffset = .init(width: 0, height: 0)
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
        picker.delegate = self
        return picker
    }()
    
    // MARK: - Property
    
    private var viewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    private var cameraManager: CameraManagable?
    
    // MARK: - Initializer

    public init(
        viewModel: HomeViewModel,
        cameraManager: CameraManagable = CameraManager()
    ) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.cameraManager = cameraManager
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraManager?.prepareCapturing(with: cameraContainerView)
    }
    
    // MARK: - Function
    
    public func bind(to viewModel: HomeViewModel) {
        switchCameraButton
            .rx
            .tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] in
                self?.cameraManager?.changeUseFrontCameraOrNot()
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { owner, _ in
                owner.cameraManager?.flipCamera()
            })
            .disposed(by: disposeBag)
        
        albumButton
            .rx
            .tap
            .throttle(.milliseconds(3), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { owner, _ in
                owner.present(owner.picker, animated: true)
            })
            .disposed(by: disposeBag)
        
        shotButton
            .rx
            .tap
            .throttle(.milliseconds(3), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self, onNext: { owner, _ in
                owner.cameraManager?.shoot { photoOutputResultType in
                    switch photoOutputResultType {
                    case .success(let photo):
                        owner.passPhotoToNextVC(photo)
                    case .fail:
                        owner.setPhotoLibraryAuthAlert()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func passPhotoToNextVC(_ photo: Data) {
        viewModel?.input.photoData.accept(photo)
        cameraManager?.endCapturing()
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

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        guard let data = image.pngData() else { return }
        
        viewModel?.input.photoData.accept(data)
       
        dismiss(animated: true, completion: nil)
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
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
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
