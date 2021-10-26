// ImageAPIServiceRepository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ImageAPIServiceProtocol {
    func loadImage(url: URL, handler: @escaping HandlerImage)
}
