//
//  CoreInterfaceModule.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/07/08.
//

import Foundation

public enum CoreInterfaceModoule: CaseIterable, ModuleInterface {
    
    case managerInterface
    case networkInterface
    case storageInterface
    case entityInterface
    
    public var name: String {
        switch self {
        case .managerInterface:
            return "CoreInterface_Manager"
        case .storageInterface:
            return "CoreInterface_Storage"
        case .networkInterface:
            return "CoreInterface_Network"
        case .entityInterface:
            return "CoreInterface_Entity"
        }
    }
    
    public var path: String {
        return "Projects/CoreInterface/\(name)"
    }
}
