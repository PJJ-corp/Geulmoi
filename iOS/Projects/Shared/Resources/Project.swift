//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/27.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Modules.shared(subModule: .resources).name,
    product: .framework,
    packages: [],
    dependencies: [],
    resources: "Resources/**",
    hasTests: false
)
