// MainScreenViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainScreenViewModelProtocol {
    var updateViewData: ((ViewData<Movie>) -> ())? { get set }
    func getData(groupID: Int)
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((ViewData<Movie>) -> ())?

    // MARK: - Private Properties

    private var repository: RepositoryProtocol?
    private var movieAPIService: MovieAPIServiceProtocol?

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol, repository: RepositoryProtocol) {
        self.movieAPIService = movieAPIService
        self.repository = repository
        updateViewData?(.loading)
    }

    // MARK: - Public methods

    func getData(groupID: Int) {
        movieAPIService?.fetchData(groupID: groupID) { [weak self] result in
            switch result {
            case let .success(movies):
                self?.updateViewData?(.loaded(movies))
            case let .failure(.jsonSerializationError(error)):
                self?.updateViewData?(.failure(description: error.localizedDescription))
            }
        }
    }
}
