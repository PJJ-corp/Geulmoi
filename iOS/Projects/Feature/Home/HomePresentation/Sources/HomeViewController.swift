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

public final class HomeViewController: UIViewController, View {
    
    // MARK: - Views
    
    private lazy var cameraContainerView = UIView()
    
    private lazy var shotButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 45
        return button
    }()
    
    private lazy var albumButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var switchCameraButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        return button
    }()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configueUI()
    }
    
    public func bind(to viewModel: HomeViewModel) {
        print("바인딩 후 코디네이터로 액션 전달되는 지 확인")
        viewModel.temporaryCallCoordinatorActionIndirectly()
    }
}

// MARK: - Configue UI

extension HomeViewController {
    
    private func configueUI() {
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
