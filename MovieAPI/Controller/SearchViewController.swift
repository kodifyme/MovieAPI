//
//  SearchViewController.swift
//  MovieAPI
//
//  Created by KOДИ on 21.05.2024.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func updateMovies(movies: [Movie])
}

class SearchViewController: UIViewController {
    
    private let movieManager = MovieManager()
    weak var delegate: SearchViewControllerDelegate?
    
    private var allMovies: [Movie] = []
    
    private lazy var searchView: SearchView = {
        var view = SearchView()
        delegate = view
        view.delegate = self
        return view
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Поиск фильмов"
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        setupConstraints()
        loadPopularMovies()
    }
    
    private func setupNavigationBar() {
        title = "Поиск"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    private func setupView() {
        view.addSubview(searchView)
    }
    
    private func loadPopularMovies() {
        Task {
            do {
                let movies = try await movieManager.fetchPopularMovies()
                self.allMovies = movies
                self.delegate?.updateMovies(movies: movies)
            } catch {
                print(error)
            }
        }
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else { return }
        Task {
            do {
                let movies = try await movieManager.searchMovies(query: query)
                self.delegate?.updateMovies(movies: movies)
            } catch {
                print(error)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.updateMovies(movies: allMovies)
    }
}

//MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func didSelectMovie(_ movie: Movie) {
        navigationController?.pushViewController(DetailViewController(movie: movie), animated: true)
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
