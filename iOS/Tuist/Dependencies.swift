//
//  Dependencies.swift
//  iOSManifests
//
//  Created by juntaek.oh on 2023/06/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies: Dependencies = .init(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies([
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .upToNextMajor(from: "6.6.0")
        )
    ],
    productTypes: [
        "RxSwift": .framework
        ],
    baseSettings: .settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
            ]
        )
    ),
    platforms: [.iOS]
)
