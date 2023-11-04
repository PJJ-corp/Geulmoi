//
//  HomeCoordinator.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import MVVMInterface
import HomePresentation
import DesignSystem

import UIKit

public final class HomeCoordinator: Coordinator {
    
    public let coordinatorType = CoordinatorType.home

    private let navigationController: UINavigationController

    public var children: [CoordinatorType:Coordinator] = [:]
    
    public let parent: CoordinatorWrapper
    
    public init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        self.parent = CoordinatorWrapper(coordinator: parent)
        setUpNavigationBar()
    }
    
    public func start() {
        let viewModel = HomeViewModel(navigator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.bind(to: viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    private func setUpNavigationBar() {
        navigationController.navigationBar.backgroundColor = .geulmoiIvory
    }
}

extension HomeCoordinator: HomeViewModelNavigation {
    
    public func showPhotoPreview(with photoData: Data) {
        let viewModel = PhotoPreviewViewModel(navigator: self)
        let viewController = PhotoPreviewViewController(with: photoData)
        viewController.bind(to: viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
    }
}

extension HomeCoordinator: PhotoPreviewViewModelNavigation {
    
    public func showTransferView() {
        print("코디네이터에서 메시지 확인")
    }
}
