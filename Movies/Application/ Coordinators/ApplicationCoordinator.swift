// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    var assembly: AssemblyProtocol?

    init(assembly: AssemblyProtocol) {
        self.assembly = assembly
    }

    // MARK: - ApplicationCoordinator

    override func start() {
        toMain()
    }

    // MARK: - Private methods

    private func toMain() {
        guard let assembly = assembly else { fatalError() }

        let coordinator = MainCoordinator(assembly: assembly)

        coordinator.onFinishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
