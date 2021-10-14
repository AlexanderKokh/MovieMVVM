// DetailMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// модель детального описания фильма
struct MovieDetail: Codable {
    /// Путь к картинке  подложки старницы фильма
    let backdropPath: String?
    /// Домашняя страница фильма
    let homepage: String?
    /// Оригинальное название фильма
    let originalTitle: String?
    /// Краткое описание фильма
    let overview: String?
    /// Путь к основному постеру фильма
    let posterPath: String?
    /// Дата выхода на экран
    let releaseDate: String?
    /// Время фильма в минутах
    let runtime: Int?
    /// Текущий статус (в прокате, выпущен, ожидается и т.д.)
    let status: String?
    /// Название фильма
    let title: String?
    /// Средний балл фильма
    let voteAverage: Float?
    /// id  фильма на сайте imdb.com
    let imdbID: String?
    /// Жанры к которым относится фильм
    let genres: [Genres]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, homepage
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case status, title
        case voteAverage = "vote_average"
    }
}

/// Жанры к которым относится фильм
struct Genres: Codable {
    /// Имя жанра
    let name: String?
}

@objc final class MovieDetailRealm: Object, Codable {
    @objc dynamic var backdropPath: String?
    /// Домашняя страница фильма
    @objc dynamic var homepage: String?
    /// Оригинальное название фильма
    @objc dynamic var originalTitle: String?
    /// Краткое описание фильма
    @objc dynamic var overview: String?
    /// Путь к основному постеру фильма
    @objc dynamic var posterPath: String?
    /// Дата выхода на экран
    @objc dynamic var releaseDate: String?
    /// Время фильма в минутах
    @objc dynamic var runtime = Int()
    /// Текущий статус (в прокате, выпущен, ожидается и т.д.)
    @objc dynamic var status: String?
    /// Название фильма
    @objc dynamic var title: String?
    /// Средний балл фильма
    @objc dynamic var voteAverage = Float()
    /// id  фильма на сайте imdb.com
    @objc dynamic var imdbID: String?
    /// id  фильма
    @objc dynamic var id = Int()

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case homepage
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case status, title, id
        case voteAverage = "vote_average"
    }

    /// Жанры к которым относится фильм

    override class func primaryKey() -> String? {
        "id"
    }

    // @objc dynamic var genre: String?
    // let genres: [Genres]?
}
