//
//  SearchViewController.swift
//  MovieAPI
//
//  Created by KOДИ on 14.05.2024.
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
    }
    
    private func setupNavigationBar() {
        title = "Поиск"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    private func setupView() {
        view.addSubview(searchView)
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
