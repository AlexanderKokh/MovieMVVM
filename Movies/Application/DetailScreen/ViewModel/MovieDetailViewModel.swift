// MovieDetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

typealias VoidHandler = (() -> ())

protocol MovieDetailViewModelProtocol {
    var movieDetail: MovieDetail? { get set }
    var updateViewData: (() -> ())? { get set }
    var showError: VoidHandler? { get set }
    var error: String? { get set }
    func getData(filmID: Int)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: VoidHandler?
    var showError: VoidHandler?
    var movieDetail: MovieDetail?
    var error: String?

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol?

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
    }

    // MARK: - Public methods

    func getData(filmID: Int) {
        fetchDetailData(filmID: filmID)
    }

    func fetchDetailData(filmID: Int) {
        movieAPIService?.fetchDataDetail(filmID: filmID) { [weak self] result in
            switch result {
            case let .success(movieDetail):
                self?.movieDetail = movieDetail
                self?.updateViewData?()
            case let .failure(.jsonSerializationError(error)):
                self?.showError?()
                self?.error = error.localizedDescription
            }
        }
    }
}
