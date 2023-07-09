//
//  ModuleType.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/06/10.
//

import Foundation

public enum Modules {
    
    case feature(subModule: FeatureModule, layerModule: FeatureSubModule)
    case core(subModule: CoreModoule)
    case shared(subModule: SharedModule)
    
    public var name: String {
        switch self {
        case .feature(_, let layerModule):
            return layerModule.type
        case .core(let subModule):
            return subModule.name
        case .shared(let subModule):
            return subModule.name
        }
    }
    
    public var path: String {
        switch self {
        case .feature(let subModule, let layerModule):
            return subModule.path + layerModule.type
        case .core(let subModule):
            return subModule.path
        case .shared(let subModule):
            return subModule.path
        }
    }
}
