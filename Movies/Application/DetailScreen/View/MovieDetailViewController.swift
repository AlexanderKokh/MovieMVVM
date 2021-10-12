// MovieDetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: - Visual Components

    private var tableview: UITableView!
    private var viewModel: MovieDetailViewModelProtocol?
    private let movieImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Public Properties

    static var id = Int()

    // MARK: - Private Properties

    private var imdbID = String()
    // private var movieDetail: MovieDetail?

    // MARK: - Initializers

    convenience init(viewModel: MovieDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    // MARK: - UIViewController

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        let nav = navigationController?.navigationBar
        nav?.barStyle = .black
        nav?.tintColor = .white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - IBAction

    @objc private func showWebView() {
        let vc = WebViewController()
        vc.imdbID = String(MovieDetailViewController.id)
        present(vc, animated: true)
    }

    // MARK: - Private Methods

    private func setupView() {
//        let movieURL = NetWorkManager.getMovieURl(urlMovieType: nil, id: MovieDetailViewController.id, page: nil)
        view.backgroundColor = .black
        createTableView()
        updateView()
        getData(filmID: "\(MovieDetailViewController.id)")
//        fetchDetailData(url: movieURL)
    }

    private func createTableView() {
        let tableViewWigth: CGFloat = view.frame.width
        let tableViewHeight: CGFloat = view.frame.height

        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: tableViewWigth, height: tableViewHeight))
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(DetailMovieTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tableview.register(CastTableViewCell.self, forCellReuseIdentifier: "CastCell")
        tableview.estimatedRowHeight = 200.0
        tableview.rowHeight = UITableView.automaticDimension
        tableview.separatorColor = .clear
        tableview.backgroundColor = .black
        view.addSubview(tableview)
    }

//    private func fetchDetailData(url: String) {
//        NetWorkManager.fetchDataDetail(url: url) { [weak self] movieDetail in
//            self?.movieDetail = movieDetail
//            DispatchQueue.main.async {
//                self?.tableview.reloadData()
//            }
//        }
//    }

    private func addGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(showWebView))
        view.addGestureRecognizer(gesture)
    }

    private func updateView() {
        viewModel?.updateViewData = { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
    }

    private func getData(filmID: String) {
        viewModel?.getData(url: filmID)
    }
}

// MARK: - UITableViewDelegate

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableview.dequeueReusableCell(
                withIdentifier: "DetailCell",
                for: indexPath
            ) as? DetailMovieTableViewCell {
                guard let movieDetail = viewModel?.movieDetail else { return UITableViewCell() }
                cell.configureCell(movie: movieDetail)
                cell.selectionStyle = .none
                cell.backgroundColor = .black
                addGesture()
                return cell
            }
        default:
            if let cell = tableview.dequeueReusableCell(
                withIdentifier: "CastCell",
                for: indexPath
            ) as? CastTableViewCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .black
                return cell
            }
        }
        return UITableViewCell()
    }
}
