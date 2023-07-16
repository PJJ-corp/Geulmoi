//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Modules.feature(subModule: .Home, layerModule: .UseCase).name,
    product: .framework,
    packages: [],
    dependencies: [
        .Module.type(.feature(subModule: .Home, layerModule: .DIContainer)).dependency,
        .Module.type(.feature(subModule: .Home, layerModule: .Repository)).dependency
    ],
    hasTests: false
)