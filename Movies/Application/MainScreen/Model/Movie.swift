// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ViewData
enum ViewData {
    case initial
    case success([Movie])
    case failure(Movie)
}

/// Модель  списка  фильмов
struct IncomingJson: Decodable {
    /// Массив фильмов с кратким описанием
    var results: [Movie]
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

/// Модель  Фильма
struct Movie1 {
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
