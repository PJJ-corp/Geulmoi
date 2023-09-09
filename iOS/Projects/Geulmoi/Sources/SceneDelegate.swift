//
//  SceneDelegate.swift
//  Geulmoi
//
//  Created by Lee, Joon Woo on 2023/09/09.
//  Copyright © 2023 Geulmoi. All rights reserved.
//

import DIContainer
import HomePresentation
import MVVMInterface

import UIKit


final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private (set)var appCoordinator: AppCoordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        self.window?.rootViewController = navigationController
        
        appCoordinator.start()
        self.appCoordinator = appCoordinator
        self.window?.makeKeyAndVisible()
   }
}
