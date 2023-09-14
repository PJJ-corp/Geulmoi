//
//  Coordinator.swift
//  MVVMInterface
//
//  Created by Lee, Joon Woo on 2023/08/07.
//  Copyright © 2023 MVVMInterface. All rights reserved.
//

import UIKit

public enum CoordinatorType {
    case app
    case home
}

public protocol Coordinator: AnyObject {
    
    /// 코디네이터 종류
    var coordinatorType: CoordinatorType { get }
    
    /// 하위 코디네이터 목록(있을 경우)
    var children: [CoordinatorType: Coordinator] { get }
    
    /// 부모 코디네이터(있을 경우)
    var parent: CoordinatorWrapper { get }
    
    init(navigationController: UINavigationController, parent: Coordinator?)
    
    func start()
}

/*
    코디네이터 인터페이스에서 parent 속성은 사실상 Coordinator? 타입이어야 함(부모가 있을 수도, 없을 수도 있는 객체임을 명시)
 
    단, Coordinator 프로토콜은 아래와 같이 옵셔널 타입을 get-only로 선언할 수 없음
        - var parent: Coordinator? { get }
 
    따라서 CoordinatorWrapper 값타입을 하나 정의하고, 내부적으로 옵셔널한 Coordinator 타입 속성을 가지도록 재정의
 */
public struct CoordinatorWrapper {
    
    public weak var coordinator: Coordinator?
    
    public init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
}
