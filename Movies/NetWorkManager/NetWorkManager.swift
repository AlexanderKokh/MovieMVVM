// NetWorkManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
enum URLList: String {
    case topRate = "top_rated"
    case popular
    case nowPlauing = "now_playing"
    case cast = "/credits"
}

final class NetWorkManager {
    // MARK: - Public Properties

    static let imageURLw500 = "https://image.tmdb.org/t/p/w500/"

    // MARK: - Public methods

    static func fetchData(url: String, compleation: @escaping (_ movies: [Movie]) -> ()) {
        let movieURL = url
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

    static func fetchDataDetail(url: String, compleation: @escaping (_ movieDetail: MovieDetail) -> ()) {
        guard let url = URL(string: url) else { return }
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

    static func fetchCastData(url: String, compleation: @escaping (_ cast: [Cast]) -> ()) {
        guard let url = URL(string: url) else { return }

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

    static func getMovieURl(urlMovieType: URLList? = nil, id: Int? = nil, page: Int? = nil) -> String {
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
}
