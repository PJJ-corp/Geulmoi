//
//  Names.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee, Joon Woo on 2023/06/21.
//

import ProjectDescription

public enum Constants {
    public static let projectName: String = "Geulmoi"
    public static let organizationName: String = "team.pjj"
    public static let bundleID: String = "com.geulmoi.pjj"
    public static let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "14.0", devices: [.iphone])
}
