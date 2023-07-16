//
//  FeatureModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import Foundation

public enum FeatureModule: CaseIterable, ModuleInterface {

    case Home
    
    public var name: String {
        switch self {
        case .Home:
            return "\(self)"
        }
    }

    public var path: String {
        return featurePath + "\(name)/\(name)"
    }
    
    public var subModules: [FeatureSubModule] {
        return FeatureSubModule.allCases
    }

}

// MARK: - FeaturePath

private let featurePath = "Projects/Feature/Feature"

// MARK: - FeatureSubModule

public enum FeatureSubModule: CaseIterable {

    case DIContainer
    case Coordinator
    case Presentation
    case UseCase
    case Repository

    var type: String {
        return "\(self)"
    }
    
}
