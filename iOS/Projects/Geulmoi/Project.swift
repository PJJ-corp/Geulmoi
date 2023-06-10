//
//  Project.swift
//  Config
//
//  Created by juntaek.oh on 2023/06/10.
//

import ProjectDescription

let projectName: String = "Geulmoi"
let organizationName: String = "team.pjj"
let bundleID: String = "com.geulmoi.pjj"

let project: Project = .init(
    name: projectName,
    organizationName: organizationName,
    targets: [
        Target(
            name: projectName,
            platform: .iOS,
            product: .app,
            bundleId: bundleID,
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .file(path: "Attributes/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "RxSwift")
            ]
        ),
        Target(
            name: "GeulmoiTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: bundleID,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: projectName)
            ]
        )
    ]
)

