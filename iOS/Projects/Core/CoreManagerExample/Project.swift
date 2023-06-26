//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Modules.core(subModule: .manager).name,
    product: .framework,
    packages: [],
    dependencies: [
        .SPM.RxSwift.dependency,
        .Module.type(.core(subModule: .service)).dependency
    ],
    hasTests: false
)
