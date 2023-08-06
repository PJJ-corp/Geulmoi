//
//  Coordinator.swift
//  MVVMInterface
//
//  Created by Lee, Joon Woo on 2023/08/07.
//  Copyright © 2023 MVVMInterface. All rights reserved.
//

import UIKit

public enum CoordinatorType {
    case example
}

public protocol Coordinator: AnyObject {
    
    // 코디네이터 종류
    var coordinatorType: CoordinatorType { get }
    // 하위 코디네이터 목록(있을 경우)
    var children: [CoordinatorType: Coordinator] { get set }
    // 부모 코디네이터(있을 경우)
    var parent: Coordinator? { get }
    // 네비게이션 컨트롤러
    var navigationController: UINavigationController { get set }
    
    func start()
}
