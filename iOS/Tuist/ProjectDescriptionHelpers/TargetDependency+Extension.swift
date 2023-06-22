//
//  TargetDependency+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/06/10.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {
        case RxSwift
        
        public var dependency: TargetDependency {
            switch self {
            case .RxSwift:
                return .external(name: "RxSwift")
            }
        }
    }
    
}