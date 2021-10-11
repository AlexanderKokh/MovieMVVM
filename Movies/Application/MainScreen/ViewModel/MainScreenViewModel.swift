// MainScreenViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MainScreenViewModelProtocol {
    var updateViewData: ((ViewData) -> ())? { get set }
    func getData(groupId: Int)
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties

    var updateViewData: ((ViewData) -> ())?

    // MARK: - Initializers

    init() {
        updateViewData?(.loading)
    }

    // MARK: - Public methods

    func getData(groupId: Int) {
        let url = getURL(groupId: groupId)
        NetWorkManager.fetchData(url: url) { [weak self] movies in
            self?.updateViewData?(.loaded(movies))
        }
    }

    // MARK: - Private methods

    private func getURL(groupId: Int) -> String {
        let url: String?
        switch groupId {
        case 0:
            url = NetWorkManager.getMovieURl(urlMovieType: .topRate)
        case 1:
            url = NetWorkManager.getMovieURl(urlMovieType: .popular)
        case 2:
            url = NetWorkManager.getMovieURl(urlMovieType: .nowPlauing)
        default:
            url = NetWorkManager.getMovieURl(urlMovieType: .topRate)
        }
        return url ?? ""
    }
}
