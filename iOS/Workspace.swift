//
//  Workspace.swift
//  iOSManifests
//
//  Created by juntaek.oh on 2023/06/10.
//

import Foundation
import ProjectDescription

let workspaceName: String = "Geulmoi"

let workspace: Workspace = .init(
    name: workspaceName,
    projects: [
        "Projects/Geulmoi"
    ])
