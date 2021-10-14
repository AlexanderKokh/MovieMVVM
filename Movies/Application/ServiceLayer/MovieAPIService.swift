// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

// typealias MovieHandler = (Result<[Movie], DownLoaderError>) -> ()
typealias MovieDetailHandler = (Result<MovieDetail, DownLoaderError>) -> ()
typealias CastHandler = (Result<[Cast], DownLoaderError>) -> ()

/// Тип запроса на получение фильма из  интернета
enum URLList: String {
    case topRate = "top_rated"
    case popular
    case nowPlauing = "now_playing"
    case cast = "/credits"
}

///  Виды ошибок при загрузки из интернета
enum DownLoaderError: Error {
    case jsonSerializationError(Error)
}

protocol MovieAPIServiceProtocol {
    func fetchDataDetail(filmID: Int, compleation: @escaping (MovieDetailHandler))
    // func fetchData(groupID: Int, compleation: @escaping (MovieHandler))
    func fetchCastData(filmID: Int, compleation: @escaping (CastHandler))
    func fetchData1(groupID: Int, compleation: @escaping ((Result<[MovieRealm], DownLoaderError>) -> ()))
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Private Properties

    private let errorSerialiaztion = "Error serialization json"

    // MARK: - Public methods

//    func fetchData(groupID: Int, compleation: @escaping (MovieHandler)) {
//        let movieURL = getURL(groupId: groupID)
//        guard let url = URL(string: movieURL) else { return }
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else { return }
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let incomingJson = try decoder.decode(IncomingJson.self, from: data)
//                let movies = incomingJson.results
//                compleation(.success(movies))
//            } catch {
//                compleation(.failure(.jsonSerializationError(error)))
//            }
//        }.resume()
//    }

    func fetchData1(groupID: Int, compleation: @escaping ((Result<[MovieRealm], DownLoaderError>) -> ())) {
        let movieURL = getURL(groupId: groupID)
        guard let url = URL(string: movieURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let incomingJson = try decoder.decode(IncomingJson.self, from: data)
                compleation(.success(incomingJson.results))
            } catch {
                compleation(.failure(.jsonSerializationError(error)))
            }
        }.resume()
    }

    func fetchDataDetail(filmID: Int, compleation: @escaping MovieDetailHandler) {
        let movieURL = getMovieURl(urlMovieType: nil, id: filmID, page: nil)

        guard let url = URL(string: movieURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                compleation(.success(movieDetail))
            } catch {
                compleation(.failure(.jsonSerializationError(error)))
            }
        }.resume()
    }

    func fetchCastData(filmID: Int, compleation: @escaping (CastHandler)) {
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
                    compleation(.success(cast))
                }
            } catch {
                compleation(.failure(.jsonSerializationError(error)))
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
