//
//  SharedModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import Foundation

public enum SharedModule: CaseIterable, ModuleInterface {
    
    case example
    
    public var name: String {
        switch self {
        case .example:
            return "SharedExampleModule"
        }
    }
    
    public var path: String {
        switch self {
        case .example:
            return "Projects/Shared/\(name)"
        }
    }
}
