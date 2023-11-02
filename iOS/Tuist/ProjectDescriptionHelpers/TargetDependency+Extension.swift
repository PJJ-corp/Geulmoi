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
        case RxCocoa
        case RxRelay
        case SnapKit
        
        public var dependency: TargetDependency {
            switch self {
            case .RxSwift:
                return .external(name: "RxSwift")
            case .RxCocoa:
                return .external(name: "RxCocoa")
            case .RxRelay:
                return .external(name: "RxRelay")
            case .SnapKit:
                return .external(name: "SnapKit")
            }
        }
    }
    
}
