// MovieDetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieDetailViewModelProtocol {
    var movieDetail: MovieDetail? { get set }
    var updateViewData: ((MovieDetail) -> ())? { get set }
    func getData(url: String)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var updateViewData: ((MovieDetail) -> ())?
    var movieDetail: MovieDetail?

    func getData(url: String) {
        let movieURL = NetWorkManager.getMovieURl(urlMovieType: nil, id: MovieDetailViewController.id, page: nil)
        fetchDetailData(url: movieURL)
    }

    func fetchDetailData(url: String) {
        NetWorkManager.fetchDataDetail(url: url) { [weak self] movieDetail in
            self?.movieDetail = movieDetail
            self?.updateViewData?(movieDetail)
        }
    }
}
