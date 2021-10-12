// MovieDetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieDetailViewModelProtocol {
    var movieDetail: MovieDetail? { get set }
    var updateViewData: ((MovieDetail) -> ())? { get set }
    func getData(filmID: Int)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var updateViewData: ((MovieDetail) -> ())?
    var movieDetail: MovieDetail?

    private var movieAPIService: MovieAPIServiceProtocol?

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
    }

    func getData(filmID: Int) {
        fetchDetailData(filmID: filmID)
    }

    func fetchDetailData(filmID: Int) {
        movieAPIService?.fetchDataDetail(filmID: filmID) { [weak self] movieDetail in
            self?.movieDetail = movieDetail
            self?.updateViewData?(movieDetail)
        }
    }
}
