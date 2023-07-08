//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/07/08.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Modules.coreInterface(interfaceModule: .managerInterface).name,
    product: .framework,
    packages: [],
    dependencies: [
        .Module.type(.core(subModule: .manager)).dependency,
    ],
    hasTests: false
)
