// MovieDetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

typealias VoidHandler = (() -> ())

protocol MovieDetailViewModelProtocol {
    var movieDetail: MovieDetail? { get set }
    var updateViewData: ((MovieDetail) -> ())? { get set }
    var showError: VoidHandler? { get set }
    var error: String? { get set }
    func getData(filmID: Int)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var updateViewData: ((MovieDetail) -> ())?
    var showError: VoidHandler?
    var movieDetail: MovieDetail?
    var error: String?

    private var movieAPIService: MovieAPIServiceProtocol?

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
    }

    func getData(filmID: Int) {
        fetchDetailData(filmID: filmID)
    }

    func fetchDetailData(filmID: Int) {
        movieAPIService?.fetchDataDetail(filmID: filmID) { [weak self] result in
            switch result {
            case let .success(movieDetail):
                self?.movieDetail = movieDetail
                self?.updateViewData?(movieDetail)
            case let .failure(.jsonSerializationError(error)):
                self?.showError?()
                self?.error = error.localizedDescription
            }
        }
    }
}
