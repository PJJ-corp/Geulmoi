//
//  FeatureModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import Foundation

// MARK: Feature 모듈 정의
public enum FeatureModule: CaseIterable, ModuleInterface {
 
    public enum SubModule: CaseIterable {
        case DIContainer
        case Coordinator
        case Presentation
        case UseCase
        case Repository
        
        var name: String {
            return "\(self)"
        }
    }

    case Home
    
    public var name: String {
        switch self {
        case .Home:
            return "\(self)"
        }
    }

    /// 모듈 경로 예시: Projects/Feature/Home
    public var path: String {
        return "Projects/Feature/\(name)"
    }
    
    /// Feature 하위 모듈(Coordinator, DIContainer, Presentation, Repository, UseCase)
    public var subModules: [SubModule] {
        return SubModule.allCases
    }

}
