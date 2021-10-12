// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias HandlerImage = (Result<UIImage, ImageLoadingError>) -> ()

// Ошибки при получении картинки из даты
enum ImageLoadingError: Error {
    case networkFailure(Error)
    case invalidData
}

protocol ImageAPIServiceProtocol {
    func loadImage(url: String, handler: @escaping HandlerImage)
}

final class ImageAPIService: ImageAPIServiceProtocol {
    private let imageURLw500 = "https://image.tmdb.org/t/p/w500/"
    private var session = URLSession.shared

    func loadImage(url: String, handler: @escaping HandlerImage) {
        if let url = URL(string: imageURLw500 + url) {
            session.dataTask(with: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(data):
                        if let image = UIImage(data: data) {
                            handler(.success(image))
                        } else {
                            handler(.failure(.invalidData))
                        }
                    case let .failure(error):
                        handler(.failure(.networkFailure(error)))
                    }
                }
            }.resume()
        }
    }
}
