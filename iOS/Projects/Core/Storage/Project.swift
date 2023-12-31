//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/27.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Modules.core(subModule: .storage).name,
    product: .framework,
    packages: [],
    dependencies: [
        .SPM.RxSwift.dependency
    ],
    hasTests: false
)
