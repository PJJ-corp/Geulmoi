import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    
    private static let organizationName: String = "team.pjj"
    private static let bundleID: String = "com.geulmoi.pjj"
    
    public static func app(name: String,
                           platform: Platform,
                           iOSTargetVersion: String,
                           infoPlist: [String: InfoPlist.Value],
                           dependencies: [TargetDependency] = []) -> Project {
        let targets = makeAppTargets(name: name,
                                     platform: platform,
                                     iOSTargetVersion: iOSTargetVersion,
                                     infoPlist: infoPlist,
                                     dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
    
    public static func frameworkWithDemoApp(name: String,
                                            platform: Platform,
                                            iOSTargetVersion: String,
                                            infoPlist: [String: InfoPlist.Value] = [:],
                                            dependencies: [TargetDependency] = []) -> Project {
        var targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           iOSTargetVersion: iOSTargetVersion,
                                           dependencies: dependencies)
        targets.append(contentsOf: makeAppTargets(name: "\(name)DemoApp",
                                                  platform: platform,
                                                  iOSTargetVersion: iOSTargetVersion,
                                                  infoPlist: infoPlist,
                                                  dependencies: [.target(name: name)]))
        
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
    
    public static func framework(name: String,
                                 platform: Platform, iOSTargetVersion: String,
                                 dependencies: [TargetDependency] = []) -> Project {
        let targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           iOSTargetVersion: iOSTargetVersion,
                                           dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
}

private extension Project {
    /// Helper function to create a framework target and an associated unit test target
    static func makeFrameworkTargets(name: String,
                                     platform: Platform,
                                     iOSTargetVersion: String,
                                     infoPlist: [String: InfoPlist.Value] = [:],
                                     dependencies: [TargetDependency]) -> [Target] {
        let sources = Target(name: name,
                platform: platform,
                product: .framework,
                bundleId: "io.tuist.\(name)",
                infoPlist: .default,
                sources: ["Targets/\(name)/Sources/**"],
                resources: [],
                dependencies: [])
        let tests = Target(name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "io.tuist.\(name)Tests",
                infoPlist: .default,
                sources: ["Targets/\(name)/Tests/**"],
                resources: [],
                dependencies: [.target(name: name)])
        return [sources, tests]
    }

    /// Helper function to create the application target and the unit test target.
    static func makeAppTargets(name: String,
                               platform: Platform,
                               iOSTargetVersion: String,
                               infoPlist: [String: InfoPlist.Value],
                               dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
            ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "io.tuist.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "io.tuist.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
        ])
        return [mainTarget, testTarget]
    }
}
