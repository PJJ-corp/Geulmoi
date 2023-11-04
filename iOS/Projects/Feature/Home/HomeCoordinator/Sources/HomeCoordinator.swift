//
//  HomeCoordinator.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import MVVMInterface
import HomePresentation

import UIKit

public final class HomeCoordinator: Coordinator {
    
    public let coordinatorType = CoordinatorType.home

    private let navigationController: UINavigationController

    public var children: [CoordinatorType:Coordinator] = [:]
    
    public let parent: CoordinatorWrapper
    
    public init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        self.parent = CoordinatorWrapper(coordinator: parent)
    }
    
    public func start() {
        let viewModel = HomeViewModel(navigator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.bind(to: viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
    }
}

extension HomeCoordinator: HomeViewModelNavigation {
    
    public func showPhotoPreview() {
        let viewModel = PhotoPreviewViewModel(navigator: self)
        let viewController = PhotoPreviewViewController()
        viewController.bind(to: viewModel)
    }
}

extension HomeCoordinator: PhotoPreviewViewModelNavigation {
    
    public func showTransferView() {
        print("코디네이터에서 메시지 확인")
    }
}
