// ImageServiceRepository.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ImageServiceProtocol {
    func getImage(url: URL, compleation: @escaping (Result<UIImage, Error>) -> Void)
}
