//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/08/11.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Modules.shared(subModule: .diContainer).name,
    product: .framework,
    packages: [],
    dependencies: [],
    hasTests: false
)
