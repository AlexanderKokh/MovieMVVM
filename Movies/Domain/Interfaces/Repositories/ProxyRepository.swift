// ProxyRepository.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol LoadImageProtocol {
    func loadImage(url: URL, compleation: @escaping (Swift.Result<UIImage, Error>) -> Void)
}
