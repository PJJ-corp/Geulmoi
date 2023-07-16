//
//  Project.swift
//  Config
//
//  Created by juntaek.oh on 2023/06/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Constants.projectName,
    product: .app,
    infoPlist: .file(path: "Attributes/Info.plist"),
    packages: [],
    dependencies: [
        .SPM.RxSwift.dependency
    ] +
    TargetDependency.Module.allDependency,
    resources: ["Resources/**"]
)
