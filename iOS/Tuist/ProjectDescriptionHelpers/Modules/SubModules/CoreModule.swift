//
//  CoreModule.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/26.
//

import Foundation

public enum CoreModule: CaseIterable, ModuleInterface {
    
    case manager
    case service
    case storage
    case entity
    
    public var name: String {
        switch self {
        case .manager:
            return "Manager"
        case .storage:
            return "Storage"
        case .service:
            return "Service"
        case .entity:
            return "Entity"
        }
    }
    
    public var path: String {
        return "Projects/Core/\(name)"
    }
}
