//
//  ModuleType.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/06/10.
//

import Foundation

public enum Modules {
    
    case feature(subModule: FeatureModule)
    
    case coreInterface(interfaceModule: CoreInterfaceModule)
    case core(subModule: CoreModule)
    case shared(subModule: SharedModule)
    
    public var name: String {
        switch self {
        case .feature(let subModule):
            return subModule.name
        case .coreInterface(let interface):
            return interface.name
        case .core(let subModule):
            return subModule.name
        case .shared(let subModule):
            return subModule.name
        }
    }
    
    public var path: String {
        switch self {
        case .feature(let subModule):
            return subModule.path
        case .coreInterface(let interface):
            return interface.path
        case .core(let subModule):
            return subModule.path
        case .shared(let subModule):
            return subModule.path
        }
    }
}
