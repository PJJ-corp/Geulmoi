//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Modules.feature(module: .Home, subModule: .DIContainer).name,
    product: .framework,
    packages: [],
    dependencies: [
        .Module.type(.shared(subModule: .diContainer)).dependency
    ],
    hasTests: false
)
