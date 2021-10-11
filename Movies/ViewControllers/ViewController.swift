// ViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Настройки кнопок
enum ButtonSettings: String {
    case buttonBackground
    case buttonShadow
    case buttonBorder
}

final class ViewController: UIViewController {
    // MARK: - Visual Components

    private var tableView: UITableView!

    // MARK: - Private Properties

    private let cellID = "MovieCell"
    private var movies: [Movie] = []

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - IBAction

    @objc private func showMovieList(selector: UIButton) {
        UIView.animate(withDuration: 0.2) {
            selector.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                selector.transform = CGAffineTransform.identity
            }
        }

        var url = ""
        switch selector.tag {
        case 0:
            url = NetWorkManager.getMovieURl(urlMovieType: .topRate)
        case 1:
            url = NetWorkManager.getMovieURl(urlMovieType: .popular)
        case 2:
            url = NetWorkManager.getMovieURl(urlMovieType: .nowPlauing)
        default:
            url = NetWorkManager.getMovieURl(urlMovieType: .topRate)
        }
        fetchData(url: url)
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .black
        createFilmButtons()
        createTableView()
        let url = NetWorkManager.getMovieURl(urlMovieType: .topRate)
        fetchData(url: url)
    }

    private func fetchData(url: String) {
        NetWorkManager.fetchData(url: url) { [weak self] movies in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func createFilmButtons() {
        let popularButton = configureRequestButton(title: "Популярные")
        popularButton.tag = 1
        view.addSubview(popularButton)
        popularButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popularButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        popularButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        popularButton.addTarget(self, action: #selector(showMovieList), for: .touchUpInside)

        let comingSoonButton = configureRequestButton(title: "В прокате")
        comingSoonButton.tag = 2
        view.addSubview(comingSoonButton)
        comingSoonButton.trailingAnchor.constraint(equalTo: popularButton.leadingAnchor, constant: -30).isActive = true
        comingSoonButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        comingSoonButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        comingSoonButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        comingSoonButton.addTarget(self, action: #selector(showMovieList), for: .touchUpInside)

        let topRateButton = configureRequestButton(title: "Топ рейтинга")
        topRateButton.tag = 0
        view.addSubview(topRateButton)
        topRateButton.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 30).isActive = true
        topRateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        topRateButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        topRateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        topRateButton.addTarget(self, action: #selector(showMovieList), for: .touchUpInside)
    }

    private func createTableView() {
        let displayWidth: CGFloat = view.frame.width
        let displayHeight: CGFloat = view.frame.height

        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: displayWidth, height: displayHeight))
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .black
        view.addSubview(tableView)
    }

    private func configureRequestButton(title: String) -> UIButton {
        let buttonTopRate: UIButton = {
            let button = UIButton()
            let fontName = "Marker Felt Thin"
            button.setTitle(title, for: .normal)
            button.backgroundColor = UIColor(named: ButtonSettings.buttonBackground.rawValue)
            button.layer.cornerRadius = 10
            button.layer.shadowColor = UIColor(named: ButtonSettings.buttonShadow.rawValue)?.cgColor
            button.layer.shadowOpacity = 0.7
            button.layer.shadowOffset = CGSize(width: 2, height: 2)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor(named: ButtonSettings.buttonBorder.rawValue)?.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont(name: fontName, size: 16)
            button.setTitleColor(.black, for: .normal)
            return button
        }()
        return buttonTopRate
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        let titleLabel = "К списку"
        vc.title = movies[indexPath.row].title
        MovieDetailViewController.id = movies[indexPath.row].id ?? 1
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: titleLabel, style: .plain, target: nil, action: nil
        )
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MovieTableViewCell {
            cell.configureCell(movie: movies[indexPath.row])
            cell.backgroundColor = .black
            return cell
        }
        return UITableViewCell()
    }
}
