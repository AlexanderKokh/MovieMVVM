// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ViewData
enum ViewData {
    case loading
    case loaded([Movie])
    case failure(description: String?, onReload: () -> ())
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
