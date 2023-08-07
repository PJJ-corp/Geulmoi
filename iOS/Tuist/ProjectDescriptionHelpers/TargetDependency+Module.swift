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
        
        public static var allDependency: [TargetDependency] {
            let sharedDependency = SharedModule.allCases.compactMap { Module.type(.shared(subModule: $0)).dependency }
            let featureDependency = getAllFeatureModules()
            
            return sharedDependency + featureDependency
        }
    }
}

// MARK: - GetFeatureModules

private func getAllFeatureModules() -> [TargetDependency] {
    let featureModules = FeatureModule.allCases.flatMap { subModule in
        subModule.subModules.map { TargetDependency.Module.type(.feature(subModule: subModule, layerModule: $0)).dependency }
    }
    
    return featureModules
}
