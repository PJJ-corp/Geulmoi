//
//  CoreModule.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/26.
//

import Foundation

public enum CoreModoule: CaseIterable, ModuleInterface {
    
    case manager
    case network
    case storage
    case entity
    
    public var name: String {
        switch self {
        case .manager:
            return "Core_Manager"
        case .storage:
            return "Core_Storage"
        case .network:
            return "Core_Network"
        case .entity:
            return "Core_Entity"
        }
    }
    
    public var path: String {
        return "Projects/Core/\(name)"
    }
}
