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
        .SPM.RxSwift.dependency,
        .Module.type(.coreInterface(interfaceModule: .managerInterface)).dependency,
        .Module.type(.coreInterface(interfaceModule: .networkInterface)).dependency,
        .Module.type(.coreInterface(interfaceModule: .storageInterface)).dependency,
        .Module.type(.coreInterface(interfaceModule: .entityInterface)).dependency,
        .Module.type(.core(subModule: .manager)).dependency,
        .Module.type(.core(subModule: .network)).dependency,
        .Module.type(.core(subModule: .storage)).dependency,
        .Module.type(.core(subModule: .entity)).dependency,
        .Module.type(.shared(subModule: .example)).dependency
    ],
    resources: ["Resources/**"]
)
