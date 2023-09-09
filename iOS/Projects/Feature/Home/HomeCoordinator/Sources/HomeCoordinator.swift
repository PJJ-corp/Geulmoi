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
    
    public weak var parent: Coordinator?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(navigator: self)
        viewController.bind(to: viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
    }
}

extension HomeCoordinator: HomeViewModelNavigation {
    
    public func nextScene() {
        print("코디네이터에서 메시지 확인")
    }
}
