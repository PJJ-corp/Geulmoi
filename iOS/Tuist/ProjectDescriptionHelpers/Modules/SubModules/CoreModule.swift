//
//  CoreModule.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/26.
//

import Foundation

public enum CoreModoule: CaseIterable, ModuleInterface {
    
    case manager
    case service
    
    case network
    case storage
    case entity
    
    case extensions
    
    public var name: String {
        switch self {
        case .manager:
            return "Core_Manager"
        case .service:
            return "Core_Service"
        case .storage:
            return "Core_Storage"
        case .network:
            return "Core_Network"
        case .entity:
            return "Core_Entity"
        case .extensions:
            return "Core_Extensions"
        }
    }
    
    public var path: String {
        return "Projects/Core/\(name)"
    }
}
