// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MainCoordinator: BaseCoordinator {
    var onFinishFlow: VoidHandler?
    var assembly: AssemblyProtocol!
    var navController: UINavigationController?

    required init(assembly: AssemblyProtocol, navController: UINavigationController? = nil) {
        self.assembly = assembly
        self.navController = navController
        super.init(assembly: assembly, navController: navController)
    }

    override func start() {
        showMainScreen()
    }

    private func showMainScreen() {
        guard let controller = assembly?.createMovieModule() as? MovieViewController else { fatalError() }

        controller.toDetailScreen = { [weak self] movieID, titleVC in
            self?.showDetailViewController(movieID: movieID, titleVC: titleVC)
        }

        if navController == nil {
            let navController = UINavigationController(rootViewController: controller)
            self.navController = navController
            setAsRoot(navController)
        } else if let navController = navController {
            navController.pushViewController(controller, animated: true)
            setAsRoot(navController)
        }
    }

    private func showDetailViewController(movieID: Int, titleVC: String) {
        guard let controller = assembly?.createMovieDetailModule(movieID: movieID) as? MovieDetailViewController
        else { fatalError() }
        controller.title = titleVC
        navController?.pushViewController(controller, animated: true)
    }
}
