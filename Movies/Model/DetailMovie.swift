// DetailMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

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
