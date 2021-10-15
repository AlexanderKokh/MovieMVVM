// MovieDetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

typealias VoidHandler = (() -> ())

protocol MovieDetailViewModelProtocol {
    var movieDetail: MovieDetailRealm? { get set }
    var updateViewData: (() -> ())? { get set }
    var showError: VoidHandler? { get set }
    var error: String? { get set }
    func getData(filmID: Int)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: VoidHandler?
    var showError: VoidHandler?
    var movieDetail: MovieDetailRealm?
    var error: String?

    // MARK: - Private Properties

    private var repository: Repository<MovieDetailRealm>?
    private var movieAPIService: MovieAPIServiceProtocol?

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol, repository: Repository<MovieDetailRealm>?) {
        self.movieAPIService = movieAPIService
        self.repository = repository
    }

    // MARK: - Public methods

    func getData(filmID: Int) {
        fetchDetailData(filmID: filmID)
    }

    // MARK: - Private methods

    private func fetchDetailData(filmID: Int) {
        let requestPredicate = NSPredicate(format: "id = \(filmID)")

        let cacheMovie = repository?.get(predicate: requestPredicate)

        if !(cacheMovie?.isEmpty ?? true) {
            guard let cacheMovie = cacheMovie else { return }
            movieDetail = cacheMovie.first
            return
        }

        movieAPIService?.fetchDataDetail(filmID: filmID) { [weak self] result in
            switch result {
            case let .success(movieDetail):
                DispatchQueue.main.async {
                    movieDetail.id = filmID
                    self?.movieDetail = movieDetail
                    self?.repository?.save(object: [movieDetail])
                    self?.updateViewData?()
                }
            case let .failure(.jsonSerializationError(error)):
                self?.showError?()
                self?.error = error.localizedDescription
            }
        }
    }
}
