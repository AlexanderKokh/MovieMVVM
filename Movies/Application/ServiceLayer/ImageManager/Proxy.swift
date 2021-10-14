// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol LoadImageProtocol {
    func loadImage(url: URL, compleation: @escaping (Swift.Result<UIImage, Error>) -> Void)
}

final class Proxy: LoadImageProtocol {
    private let imageAPIService: ImageAPIServiceProtocol
    private let fileManagerService: FileManagerServiceProtocol

    init(imageAPIService: ImageAPIServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.fileManagerService = fileManagerService
    }

    func loadImage(url: URL, compleation: @escaping (Result<UIImage, Error>) -> Void) {
        let image = fileManagerService.getImageFromCache(url: url.absoluteString)

        if image == nil {
            imageAPIService.loadImage(url: url) { result in
                switch result {
                case let .success(image):
                    self.fileManagerService.saveImageToCache(url: url.absoluteString, image: image)
                    compleation(.success(image))
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } else {
            guard let image = image else { return }
            compleation(.success(image))
        }
    }
}
