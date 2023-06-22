//
//  FeatureModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import Foundation

public enum FeatureModule: CaseIterable, ModuleInterface {
    
    case home
    
    public var name: String {
        switch self {
        case .home:
            return "Home"
        }
    }
    
    public var path: String {
        ""
    }
}
