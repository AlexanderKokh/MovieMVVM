// CastTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CastTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private var collectionView: UICollectionView!
    private var id: Int?

    private let backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Private Properties

    private var cast: [Cast] = []
    private let cellIdintifier = "ActorCell"
    private lazy var movieAPIService = MovieAPIService()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // setupCell(FilmID: Int)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    func setupCell(filmID: Int) {
        id = filmID
        createCollectionView()
        fetchDetailData(filmID: id ?? 0)
    }

    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: cellIdintifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        contentView.addSubview(backGroundView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        createConstraints()
    }

    private func createConstraints() {
        NSLayoutConstraint.activate(
            [
                backGroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
                backGroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                backGroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                backGroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ]
        )
        backGroundView.addSubview(collectionView)

        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: backGroundView.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 200)
            ]
        )
    }

    private func fetchDetailData(filmID: Int) {
        movieAPIService.fetchCastData(filmID: filmID) { [weak self] result in
            switch result {
            case let .failure(.jsonSerializationError(error)):
                print(error.localizedDescription)
            case let .success(cast):
                self?.cast = cast
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CastTableViewCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout

extension CastTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 200, height: 200)
    }
}

// MARK: - UICollectionViewDataSource

extension CastTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdintifier,
            for: indexPath
        ) as? CastCollectionViewCell {
            cell.configureCell(cast: cast[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
