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
        .Module.type(.shared(subModule: .example)).dependency,
        .Module.type(.feature(subModule: .Home, layerModule: .DIContainer)).dependency,
        .Module.type(.feature(subModule: .Home, layerModule: .Coordinator)).dependency,
        .Module.type(.feature(subModule: .Home, layerModule: .UseCase)).dependency,
        .Module.type(.feature(subModule: .Home, layerModule: .Repository)).dependency,
        .Module.type(.feature(subModule: .Home, layerModule: .Presentation)).dependency
    ],
    resources: ["Resources/**"]
)
