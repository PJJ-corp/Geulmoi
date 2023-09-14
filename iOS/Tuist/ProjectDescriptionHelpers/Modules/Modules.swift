//
//  ModuleType.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/06/10.
//

import Foundation

public enum Modules {
    case feature(module: FeatureModule, subModule: FeatureModule.SubModule)
    case core(subModule: CoreModule)
    case shared(subModule: SharedModule)
    
    public var name: String {
        switch self {
        case .feature(let module, let subModule):
            // 모듈이름 + 서브모듈 이름(ex. Home + Coordinator = HomeCoordinator)
            return "\(module.name)\(subModule.name)"
        case .core(let subModule):
            return subModule.name
        case .shared(let subModule):
            return subModule.name
        }
    }
    
    public var path: String {
        switch self {
        case .feature(let module, let subModule):
            return "\(module.path)/\(module.name)\(subModule.name)"
        case .core(let subModule):
            return subModule.path
        case .shared(let subModule):
            return subModule.path
        }
    }
}
