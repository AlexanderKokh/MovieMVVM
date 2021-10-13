// UITableViewCell + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UITableViewCell {
    func loadImage(path: String?, imageView: UIImageView?) {
        ImageLoader.loadImage(path: path, imageView: imageView)
    }
}
