//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/07/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Modules.feature(subModule: .Home, layerModule: .Coordinator).name,
    product: .framework,
    packages: [],
    dependencies: [
        .Module.type(.shared(subModule: .mvvmInterface)).dependency,
        .Module.type(.feature(subModule: .Home, layerModule: .DIContainer)).dependency
    ],
    hasTests: false
)
