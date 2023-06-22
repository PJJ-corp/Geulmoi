//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/22.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Modules.shared(subModule: .example).name,
    // App 타겟을 제외하면 동적/정적 framework 중 어느 하나로 설정
    product: .framework,
    packages: [],
    dependencies: [
        .SPM.RxSwift.dependency
    ],
    hasTests: false
)
