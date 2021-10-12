//
//  UICollectionViewCell + Extension.swift
//  Movies
//
//  Created by Alexander Kokh on 12.10.2021.
//

import UIKit

extension UICollectionViewCell {

    func loadImage(path: String?, imageView: UIImageView?) {
       ImageLoader.loadImage(path: path, imageView: imageView)
    }
}

