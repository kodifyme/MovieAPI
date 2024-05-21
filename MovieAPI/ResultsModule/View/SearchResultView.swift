//
//  SearchResultView.swift
//  MovieAPI
//
//  Created by KOДИ on 20.05.2024.
//

import UIKit

class SearchResultView: UIView {
    
    var movies: [Movie] = [] {
        didSet {
            searchResultTableView.reloadData()
        }
    }
    
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setDelegates()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchResultTableView)
    }
    
    private func setDelegates() {
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension SearchResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchResultTableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchResultView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

//MARK: - Constraints
private extension SearchResultView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchResultTableView.topAnchor.constraint(equalTo: topAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchResultTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchResultTableView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
