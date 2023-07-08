//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/07/08.
//

import Foundation

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Modules.coreInterface(interfaceModule: .networkInterface).name,
    product: .framework,
    packages: [],
    dependencies: [
        .Module.type(.core(subModule: .network)).dependency,
    ],
    hasTests: false
)
