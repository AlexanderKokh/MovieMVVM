// MainScreenViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol MainScreenViewModelProtocol {
    var updateViewData: ((ViewData<MovieRealm>) -> ())? { get set }

    func getData(groupID: Int)
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((ViewData<MovieRealm>) -> ())?

    // MARK: - Private Properties

    private var repository: Repository<MovieRealm>?
    private var movieAPIService: MovieAPIServiceProtocol?

    var adfhsdjk = 0

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol, repository: Repository<MovieRealm>?) {
        self.movieAPIService = movieAPIService
        self.repository = repository
        updateViewData?(.loading)
    }

    // MARK: - Public methods

    func getData(groupID: Int) {
        movieAPIService?.fetchData1(groupID: groupID) { [weak self] result in
            switch result {
            case let .success(movies):
                DispatchQueue.main.async {
                    self?.repository?.save(object: movies)
                    self?.updateViewData?(.loaded(movies))
                }
            case let .failure(.jsonSerializationError(error)):
                print(error)
            }
        }
    }
}
