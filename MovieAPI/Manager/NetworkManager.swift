//
//  NetworkManager.swift
//  MovieAPI
//
//  Created by KOДИ on 20.05.2024.
//

import UIKit

struct Constants {
    static let baseURLPath = "https://api.themoviedb.org/3"
    static let API_KEY = "a5437d346e782df5011c4a6fc09611da"
    static let searchPath = "search/movie"
    static let popularPath = "movie/popular"
    static let imageURLPath = "https://image.tmdb.org/t/p"
    static let fileSize = "w500"
}

class NetworkManager {
    
    struct QueryItem {
        static let API_KEY = "api_key"
        static let query = "query"
    }
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private lazy var mainURL: URL? = {
        URL(string: Constants.baseURLPath)
    }()
    
    private lazy var imageURL: URL? = {
        URL(string: Constants.imageURLPath)
    }()
    
    func fetchImages(posterPath: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let baseURL = URL(string: Constants.imageURLPath) else { return }

        let fullURL = baseURL
            .appendingPathComponent(Constants.fileSize)
            .appendingPathComponent(posterPath)

        let task = URLSession.shared.dataTask(with: fullURL) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let mainURL else { return }
        let searchURL = mainURL.appending(path: Constants.searchPath)
        guard var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true) else { return }
        
        components.queryItems = [
            URLQueryItem(name: QueryItem.API_KEY, value: Constants.API_KEY),
            URLQueryItem(name: QueryItem.query, value: query)
        ]
        
        guard let searchURL = components.url else { return }
        let task = URLSession.shared.dataTask(with: searchURL) { data, _, error in
            guard let data, error == nil else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.movies))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let mainURL else { return }
        let popularURL = mainURL.appending(path: Constants.popularPath)
        guard var components = URLComponents(url: popularURL, resolvingAgainstBaseURL: true) else { return }
        components.queryItems = [URLQueryItem(name: QueryItem.API_KEY, value: Constants.API_KEY)]
        
        guard let popupalURL = components.url else { return }
        let task = URLSession.shared.dataTask(with: popupalURL) { data, _, error in
            guard let data, error == nil else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.movies))
                }
                print(results.movies)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
