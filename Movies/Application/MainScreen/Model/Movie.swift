// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// UI Data Driven
enum ViewData<Model> {
    case loading
    case loaded([Model])
    case failure(description: String?)
}

/// Модель  списка  фильмов
struct IncomingJson: Decodable {
    /// Массив фильмов с кратким описанием
    var results: [MovieRealm]
    /// Количество страниц с фильмами
    let totalPages, totalResults: Int
}

/// Модель  Фильма
struct Movie: Decodable {
    /// Путь к картинке  подложки старницы фильма
    var backdropPath: String?
    /// Id фильма
    var id: Int?
    /// Название фильма
    var title: String?
    /// Путь к основному постеру фильма
    var posterPath: String?
    /// Краткое описание
    var overview: String?
    /// Рейтинг фильма
    var voteAverage: Float?
}

//
///// PageDataMovie
// struct PageDataMovie {
//    var movies: [IncomingJson]
// }
//
// extension PageDataMovie: Decodable {
//    private enum MovieCodingKeys: String, CodingKey {
//        case movies = "results"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
//        movies = try container.decode([IncomingJson].self, forKey: .movies)
//    }
// }

final class IncomingJsonRealm: Codable {
    /// Массив фильмов с кратким описанием
    var results: [MovieRealm]
    /// Количество страниц с фильмами
    var totalPages = Int()
    var totalResults = Int()
}

@objc final class MovieRealm: Object, Codable {
    @objc dynamic var backdropPath = String()
    /// Id фильма
    @objc dynamic var id = Int()
    /// Название фильма
    @objc dynamic var title = String()
    /// Путь к основному постеру фильма
    @objc dynamic var posterPath = String()
    /// Краткое описание
    @objc dynamic var overview = String()
    /// Рейтинг фильма
    @objc dynamic var voteAverage = Float()

//    override class func primaryKey() -> String? {
//        "id"
//    }
}

// extension RealmSwift.List: Decodable where Element: Decodable {
//    public convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.singleValueContainer()
//        let decodedElements = try container.decode([Element].self)
//        self.append(objectsIn: decodedElements)
//    }
// }
//
//
//
// extension RealmSwift.List: Encodable where Element: Encodable {
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encode(self.map { $0 })
//    }
// }
