// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MainCoordinator: BaseCoordinator {
    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?

    override func start() {
        showMainScreen()
    }

    private func showMainScreen() {
        let controller = MovieViewController()

        controller.toDetailScreen = { [weak self] in
            self?.showDetailViewController()
        }

        rootController = UINavigationController(rootViewController: controller)

        guard let rootController = rootController else { return }
        setAsRoot(rootController)
    }

    private func showDetailViewController() {
        let controller = MovieDetailViewController()
        rootController?.pushViewController(controller, animated: true)
    }
}
