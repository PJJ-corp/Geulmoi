//
//  FeatureModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import Foundation

public enum FeatureModule: String, ModuleInterface {

    case Home
    
    public var name: String {
        return "\(self)"
    }

    public var path: String {
        switch self {
        case .Home:
            return "Projects/Feature/Feature\(name)/"
        }
    }

}

// MARK: - FeatureSubModule

public enum FeatureSubModule {

    case DIContainer
    case Coordinator
    case Presentation
    case UseCase
    case Repository

    var type: String {
        return "\(self)"
    }

}
