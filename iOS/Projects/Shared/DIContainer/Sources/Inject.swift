//
//  DependencyInject.swift
//  DIContainer
//
//  Created by Lee, Joon Woo on 2023/08/13.
//  Copyright © 2023 DIContainer. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Inject<T> {
    
    private let implement: T
    
    public init() {
        self.implement = DIContainer.resolve()
    }
    
    public var wrappedValue: T {
        self.implement
    }
}
