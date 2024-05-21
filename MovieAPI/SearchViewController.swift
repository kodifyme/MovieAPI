//
//  SearchViewController.swift
//  MovieAPI
//
//  Created by KOДИ on 21.05.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    private let searchController: UISearchController = {
        let resultController = SearchResultViewController()
        let controller = UISearchController(searchResultsController: resultController)
        controller.searchBar.placeholder = "Поиск фильмов"
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraints()
        fetchPopularMovies()
    }
    
    private func setupNavigationBar() {
        title = "Поиск"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    private func setupView() {
        view.addSubview(searchView)
    }
    
    private func fetchPopularMovies() {
        NetworkManager.shared.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.searchView.movies = movies
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else { return }
        NetworkManager.shared.searchMovies(query: query) { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    if let resultsController = self?.searchController.searchResultsController as? SearchResultViewController {
                        resultsController.searchResultView.movies = movies
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - Constraints
private extension SearchViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
