//
//  SearchResultViewController.swift
//  MovieAPI
//
//  Created by KOДИ on 16.05.2024.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    private let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        view.backgroundColor = .red
    }
    
    private func setupView() {
        view.addSubview(searchView)
    }
}

//MARK: - Constraints
private extension SearchResultViewController{
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
