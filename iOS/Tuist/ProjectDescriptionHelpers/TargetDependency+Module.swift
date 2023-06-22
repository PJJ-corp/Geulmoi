//
//  TargetDependency+Module.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/22.
//

import ProjectDescription

public extension TargetDependency {
    
    enum Module {
        case type(Modules)
        
        public var dependency: TargetDependency {
            switch self {
            case .type(let module):
                return .project(target: module.name, path: .relativeToRoot(module.path))
            }
        }
    }
}
