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

//
///// Модель  Фильма
// struct Movie: Decodable {
//    /// Путь к картинке  подложки старницы фильма
//    var backdropPath: String?
//    /// Id фильма
//    var id: Int?
//    /// Название фильма
//    var title: String?
//    /// Путь к основному постеру фильма
//    var posterPath: String?
//    /// Краткое описание
//    var overview: String?
//    /// Рейтинг фильма
//    var voteAverage: Float?
// }
//
// final class IncomingJsonRealm: Codable {
//    /// Массив фильмов с кратким описанием
//    var results: [MovieRealm]
//    /// Количество страниц с фильмами
//    var totalPages = Int()
//    var totalResults = Int()
// }

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
    ///
    @objc dynamic var category: String?
    ///
    @objc dynamic var keyField: String?

    override class func primaryKey() -> String? {
        "keyField"
    }
}
