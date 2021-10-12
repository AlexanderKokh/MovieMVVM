// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
enum URLList: String {
    case topRate = "top_rated"
    case popular
    case nowPlauing = "now_playing"
    case cast = "/credits"
}

protocol MovieAPIServiceProtocol {
    func fetchData(groupID: Int, compleation: @escaping (_ movies: [Movie]) -> ())
    func fetchDataDetail(filmID: Int, compleation: @escaping (_ movieDetail: MovieDetail) -> ())
    func fetchCastData(filmID: Int, compleation: @escaping (_ cast: [Cast]) -> ())
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Public Properties

    // MARK: - Public methods

    func fetchData(groupID: Int, compleation: @escaping (_ movies: [Movie]) -> ()) {
        let movieURL = getURL(groupId: groupID)
        guard let url = URL(string: movieURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let incomingJson = try decoder.decode(IncomingJson.self, from: data)
                let movies = incomingJson.results
                compleation(movies)
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
    }

    func fetchDataDetail(filmID: Int, compleation: @escaping (_ movieDetail: MovieDetail) -> ()) {
        let movieURL = getMovieURl(urlMovieType: nil, id: filmID, page: nil)

        guard let url = URL(string: movieURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                compleation(movieDetail)
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
    }

    func fetchCastData(filmID: Int, compleation: @escaping (_ cast: [Cast]) -> ()) {
        let movieURL = getMovieURl(urlMovieType: .cast, id: filmID)

        guard let url = URL(string: movieURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodeData = try decoder.decode(CastList.self, from: data)
                let cast = decodeData.cast
                DispatchQueue.main.async {
                    compleation(cast)
                }
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
    }

    private func getMovieURl(urlMovieType: URLList? = nil, id: Int? = nil, page: Int? = nil) -> String {
        let connection = Host.shared
        var connectionString = "\(connection.host)"

        if let id = id {
            connectionString += "\(id)"
        }

        if let urlMovieType = urlMovieType {
            connectionString += "\(urlMovieType.rawValue)"
        }

        let language = "&language=ru-RU"
        connectionString += "\(connection.api)\(language)"

        if let page = page {
            connectionString += "&page=\(page)"
        }

        return connectionString
    }

    private func getURL(groupId: Int) -> String {
        let url: String?
        switch groupId {
        case 0:
            url = getMovieURl(urlMovieType: .topRate)
        case 1:
            url = getMovieURl(urlMovieType: .popular)
        case 2:
            url = getMovieURl(urlMovieType: .nowPlauing)
        default:
            url = getMovieURl(urlMovieType: .topRate)
        }
        return url ?? ""
    }
}