//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Jihee hwang on 2023/11/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Modules.designSystem(subModule: .designSystem).name,
    product: .framework,
    packages: [],
    dependencies: [],
    hasTests: false
)
