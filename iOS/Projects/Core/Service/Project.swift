//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/27.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Modules.core(subModule: .service).name,
    product: .framework,
    packages: [],
    dependencies: [
        .SPM.RxSwift.dependency,
        .SPM.RxRelay.dependency,
        .Module.type(.core(subModule: .entity)).dependency,
        .Module.type(.shared(subModule: .resources)).dependency
    ],
    hasTests: false
)
