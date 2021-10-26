// FileManagerRepository.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol FileManagerServiceProtocol {
    func getImageFromCache(url: String) -> UIImage?
    func saveImageToCache(url: String, image: UIImage)
}
