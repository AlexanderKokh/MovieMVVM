// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MainCoordinator: BaseCoordinator {
    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?
    var assembly: AssemblyProtocol?

    init(assembly: AssemblyProtocol) {
        self.assembly = assembly
    }

    override func start() {
        showMainScreen()
    }

    private func showMainScreen() {
        guard let controller = assembly?.createMovieModule() as? MovieViewController else { fatalError() }

        controller.toDetailScreen = { [weak self] movieID, titleVC in
            self?.showDetailViewController(movieID: movieID, titleVC: titleVC)
        }

        rootController = UINavigationController(rootViewController: controller)

        guard let rootController = rootController else { return }
        setAsRoot(rootController)
    }

    private func showDetailViewController(movieID: Int, titleVC: String) {
        guard let controller = assembly?.createMovieDetailModule(movieID: movieID) as? MovieDetailViewController
        else { fatalError() }
        controller.title = titleVC
        rootController?.pushViewController(controller, animated: true)
    }
}
