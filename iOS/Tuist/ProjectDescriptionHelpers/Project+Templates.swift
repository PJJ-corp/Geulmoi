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
                            coreDataModels: [CoreDataModel] = [],
                            hasTests: Bool = true
                            ) -> Project {
        
        // 1. 타겟 생성
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "com.\(Constants.projectName).\(name)",
            deploymentTarget: Constants.deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
        
        // 2. Test 타겟 생성
        let testTarget = Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.\(Constants.projectName).\(name)Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: name)
            ]
        )
        
        // 3. 리턴할 타겟 목록 지정(hasTest = true일 때만 테스트 타겟 적용)
        let targets: [Target] = hasTests ? [mainTarget, testTarget] : [mainTarget]
        
        // 4. 배포 설정(ex. debug, release 버전 등)
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
