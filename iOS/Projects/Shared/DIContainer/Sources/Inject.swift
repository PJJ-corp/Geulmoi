//
//  DependencyInject.swift
//  DIContainer
//
//  Created by Lee, Joon Woo on 2023/08/13.
//  Copyright © 2023 DIContainer. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Inject<T, Container: DIContainer> {
    
    private let implement: T
    
    public init() {
        self.implement = Container.resolve()
    }
    
    public var wrappedValue: T {
        self.implement
    }
}
