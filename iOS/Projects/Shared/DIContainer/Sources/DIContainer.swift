//
//  DIContainerInterface.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/08/12.
//

import Foundation

public protocol DIContainer {
    
    static var dependencies: [String: Any] { get set }
}

extension DIContainer {

    /// 외부에서 의존성 주입
    public static func register<T>(service: T.Type, _ resolve: @escaping () -> T) {
        let key = String(describing: T.self)
        dependencies[key] = resolve
    }
    
    static func resolve<T>() -> T {
        let key = String(describing: T.self)
        
        guard let resolve = dependencies[key] as? () -> T else {
            fatalError("Dependency \(T.self) cannot be resolved. Check whether the dependency is registered in \(type(of: self)).")
        }
        
        return resolve()
    }
}
