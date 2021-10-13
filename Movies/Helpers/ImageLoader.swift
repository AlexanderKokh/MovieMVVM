// ImageLoader.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Загрузка изображений
struct ImageLoader {
    // MARK: - Initializers

    private init() {}

    // MARK: - Public methods

    static func loadImage(path: String?, imageView: UIImageView?) {
        let imageService = ImageAPIService()

        if let backdropPath = path {
            imageService.loadImage(url: backdropPath) { [weak imageView] result in
                switch result {
                case let .success(image):
                    imageView?.image = image
                case .failure(.invalidData):
                    print("invalidData")
                case let .failure(.networkFailure(error)):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
