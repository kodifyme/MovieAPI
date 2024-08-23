//
//  SearchView.swift
//  MovieAPI
//
//  Created by KOДИ on 21.05.2024.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didSelectMovie(_ movie: Movie)
}

class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate?
    private var movies: [Movie] = [] 
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
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
        addSubview(searchTableView)
    }
    
    private func setDelegates() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectMovie(movies[indexPath.row])
    }
}

//MARK: - SearchViewControllerDelegate
extension SearchView: SearchViewControllerDelegate {
    func updateMovies(movies: [Movie]) {
        self.movies = movies
        self.searchTableView.reloadData()
    }
}
//MARK: - Constraints
private extension SearchView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: topAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchTableView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
