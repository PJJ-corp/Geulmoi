//
//  CoreModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import Foundation

public enum CoreModoule: CaseIterable, ModuleInterface {
    
    case entity
    
    public var name: String {
        switch self {
        case .entity:
            return "Entity"
        }
    }
    
    public var path: String {
        ""
    }
}
