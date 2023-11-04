//
//  SharedModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import Foundation

public enum SharedModule: CaseIterable, ModuleInterface {
    
    case mvvmInterface
    case diContainer
    case resources
    
    public var name: String {
        switch self {
        case .mvvmInterface:
            return "MVVMInterface"
        case .diContainer:
            return "DIContainer"
        case .resources:
            return "Resources"
        }
    }
    
    public var path: String {
        switch self {
        default:
            return "Projects/Shared/\(name)"
        }
    }
}
