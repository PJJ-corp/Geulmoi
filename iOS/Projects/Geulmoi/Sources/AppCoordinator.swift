//
//  AppCoordinator.swift
//  Geulmoi
//
//  Created by Lee, Joon Woo on 2023/08/20.
//  Copyright © 2023 Geulmoi. All rights reserved.
//

import HomeCoordinator
import HomePresentation
import MVVMInterface

import UIKit

final class AppCoordinator: Coordinator {
    
    let coordinatorType = CoordinatorType.app

    private let navigationController: UINavigationController

    private (set)var children: [CoordinatorType:Coordinator] = [:]
    
    let parent: CoordinatorWrapper
    
    init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        self.parent = CoordinatorWrapper(coordinator: parent)
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController, parent: self)
        self.children[homeCoordinator.coordinatorType] = homeCoordinator
        homeCoordinator.start()
    }
}
