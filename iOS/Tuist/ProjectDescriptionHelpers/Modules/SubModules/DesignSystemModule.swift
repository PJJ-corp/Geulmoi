//
//  DesignSystemModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/11/01.
//

import Foundation

public enum DesignSystemModule: CaseIterable, ModuleInterface {
    
    case designSystem
    
    public var name: String {
        switch self {
        case .designSystem:
            return "DesignSystem"
        }
    }
    
    public var path: String {
        switch self {
        default:
            return "Projects/DesignSystem/\(name)"
        }
    }
}
