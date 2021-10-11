// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navController = UINavigationController()
        let viewModel = MainScreenViewModel()
        let vc = MovieViewController(viewModel: viewModel)
        navController.viewControllers = [vc]
        navController.navigationBar.isHidden = true

        self.window?.rootViewController = navController
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
    }
}
