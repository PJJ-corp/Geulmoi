//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "Geulmoi"

let project: Project = .app(
    name: projectName,
    platform: .iOS,
    additionalTargets: []
)
