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
        switch self {
        case .Home:
            return "Home"
        }
    }

    public var path: String {
        switch self {
        case .Home:
            return "Projects/Feature/Feature\(name)/\(name)"
        }
    }

}

// MARK: - FeatureSubModule

public enum FeatureSubModule: CustomStringConvertible {

    case DIContainer
    case Coordinator
    case Presentation
    case UseCase
    case Repository

    var type: String {
        return "\(self.description)"
    }
    
    public var description: String {
        switch self {
        case .DIContainer:
            return "DIContainer"
        case .Coordinator:
            return "Coordinator"
        case .Presentation:
            return "Presentation"
        case .UseCase:
            return "UseCase"
        case .Repository:
            return "Repository"
        }
    }

}
