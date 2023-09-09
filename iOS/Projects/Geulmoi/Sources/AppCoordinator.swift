//
//  AppCoordinator.swift
//  Geulmoi
//
//  Created by Lee, Joon Woo on 2023/08/20.
//  Copyright © 2023 Geulmoi. All rights reserved.
//

import UIKit
import MVVMInterface

final class AppCoordinator: Coordinator {
    
    let coordinatorType = CoordinatorType.app

    private let navigationController: UINavigationController

    private (set)var children: [CoordinatorType:Coordinator] = [:]
    
    weak var parent: Coordinator? = nil
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("flow 시작할 뷰 적용")
    }

}
