//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by juntaek.oh on 2023/06/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Modules.core(subModule: .service).name,
    product: .framework,
    packages: [],
    dependencies: [.SPM.RxSwift.dependency],
    hasTests: true
)
