//
//  CoreInterfaceModule.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/07/08.
//

import Foundation

public enum CoreInterfaceModule: CaseIterable, ModuleInterface {
    
    case managerInterface
    case serviceInterface
    case storageInterface
    case entityInterface
    
    public var name: String {
        switch self {
        case .managerInterface:
            return "ManagerInterface"
        case .storageInterface:
            return "StorageInterface"
        case .serviceInterface:
            return "ServiceInterface"
        case .entityInterface:
            return "EntityInterface"
        }
    }
    
    public var path: String {
        return "Projects/CoreInterface/\(name)"
    }
}
