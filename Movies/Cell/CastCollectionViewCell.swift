// CastCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let actorImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()

    // MARK: - Initializers

    override func layoutSubviews() {
        super.layoutSubviews()
        actorImageView.frame = contentView.bounds
        contentView.addSubview(actorImageView)
    }

    // MARK: - Public Methods

    func configureCell(cast: Cast) {
        if let pathToImage = cast.profilePath {
            DispatchQueue.global().async {
                guard let backgroundImageURL = URL(string: MovieAPIService.imageURLw500 + pathToImage) else { return }
                guard let backgroundImageData = try? Data(contentsOf: backgroundImageURL) else { return }
                DispatchQueue.main.async {
                    self.actorImageView.image = UIImage(data: backgroundImageData)
                }
            }
        } else {
            actorImageView.image = UIImage(named: "NoFoto")
        }
    }
}
