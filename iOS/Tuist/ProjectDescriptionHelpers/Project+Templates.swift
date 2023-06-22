import ProjectDescription

public extension Project {
    
    static func makeProject(name: String,
                            platform: Platform = .iOS,
                            product: Product,
                            infoPlist: InfoPlist = .default,
                            packages: [Package],
                            dependencies: [TargetDependency],
                            sources: SourceFilesList = ["Sources/**"],
                            resources: ResourceFileElements? = nil,
                            hasTests: Bool = true
                            ) -> Project {
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: Constants.bundleID,
            deploymentTarget: Constants.deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies

        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: Constants.bundleID,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: name)
            ]
        )
        
        let targets: [Target] = hasTests ? [mainTarget, testTarget] : [mainTarget]
        
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended)
        
        return Project(
            name: name,
            organizationName: name,
            packages: packages,
            settings: settings,
            targets: targets
        )
    }
}
