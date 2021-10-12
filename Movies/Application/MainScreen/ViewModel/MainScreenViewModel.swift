// MainScreenViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainScreenViewModelProtocol {
    var updateViewData: ((ViewData<Movie>) -> ())? { get set }
    func getData(groupID: Int)
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties

    private var movieAPIService: MovieAPIServiceProtocol?
    var updateViewData: ((ViewData<Movie>) -> ())?

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
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
