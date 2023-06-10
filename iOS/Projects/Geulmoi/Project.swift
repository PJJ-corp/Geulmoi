//
//  Project.swift
//  Config
//
//  Created by juntaek.oh on 2023/06/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(name: Names.projectName,
                                  product: .app,
                                  infoPlist: .file(path: "Attributes/Info.plist"),
                                  dependencies: [.SPM.RxSwift.dependency])
