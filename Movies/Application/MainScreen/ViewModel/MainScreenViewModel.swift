// MainScreenViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainScreenViewModelProtocol {
    var updateViewData: ((ViewData<MovieRealm>) -> ())? { get set }
    func getData(groupID: Int)
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((ViewData<MovieRealm>) -> ())?

    // MARK: - Private Properties

    private enum Constants {
        static let queryFile = "category"
    }

    private var repository: Repository<MovieRealm>?
    private var movieAPIService: MovieAPIServiceProtocol?

    // MARK: - Initializers

    init(
        movieAPIService: MovieAPIServiceProtocol,
        repository: Repository<MovieRealm>?
    ) {
        self.movieAPIService = movieAPIService
        self.repository = repository
        updateViewData?(.loading)
    }

    // MARK: - Public methods

    func getData(groupID: Int) {
        let filter = "\(groupID)"

        let requestPredicate = NSPredicate(format: "\(Constants.queryFile) == %@", filter)

        let casheMovie = repository?.get(predicate: requestPredicate)

        if !(casheMovie?.isEmpty ?? true) {
            guard let casheMovie = casheMovie else { return }
            updateViewData?(.loaded(casheMovie))
            return
        }

        movieAPIService?.fetchData(groupID: groupID) { [weak self] result in
            switch result {
            case let .success(movies):
                DispatchQueue.main.async {
                    movies.forEach {
                        $0.category = String(groupID)
                        $0.keyField = "Category:\(groupID) id: \($0.id)"
                    }
                    self?.repository?.save(object: movies)
                    self?.updateViewData?(.loaded(movies))
                }
            case let .failure(.jsonSerializationError(error)):
                self?.updateViewData?(.failure(description: error.localizedDescription))
            }
        }
    }
}
