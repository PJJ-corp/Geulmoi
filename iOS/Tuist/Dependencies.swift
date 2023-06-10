//
//  Dependencies.swift
//  Config
//
//  Created by juntaek.oh on 2023/06/10.
//

import ProjectDescription

let dependencies: Dependencies = .init(
    carthage: [],
    swiftPackageManager: [
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .upToNextMajor(from: "6.6.0")
        )
    ],
    platforms: [.iOS]
)
