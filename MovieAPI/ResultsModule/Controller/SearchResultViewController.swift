//
//  SearchResultViewController.swift
//  MovieAPI
//
//  Created by KOДИ on 16.05.2024.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    let searchResultView = SearchResultView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(searchResultView)
    }
}

//MARK: - Constraints
private extension SearchResultViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchResultView.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
