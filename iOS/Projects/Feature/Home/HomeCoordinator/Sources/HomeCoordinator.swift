//
//  HomeCoordinator.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import UIKit
import MVVMInterface

final class HomeCoordinator: Coordinator {
    
    let coordinatorType = CoordinatorType.home

    let navigationController: UINavigationController

    private (set)var children: [CoordinatorType:Coordinator] = [:]
    
    weak var parent: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("flow 시작할 뷰 적용")
    }
}
