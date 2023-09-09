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
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
