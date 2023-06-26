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
            return "Manager"
        case .service:
            return "Service"
        case .storage:
            return "Storage"
        case .network:
            return "Network"
        case .entity:
            return "Entity"
        case .extensions:
            return "Extensions"
        }
    }
    
    public var path: String {
        return "Projects/Core/\(name)"
    }
}
