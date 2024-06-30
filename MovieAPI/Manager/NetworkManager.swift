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
    private let session = URLSession.shared
    
    private init() {}
    
    private lazy var mainURL: URL? = {
        URL(string: Constants.baseURLPath)
    }()
    
    private lazy var imageURL: URL? = {
        URL(string: Constants.imageURLPath)
    }()
    
    func fetchImage(posterPath: String) async throws -> UIImage {
        guard let baseURL = URL(string: Constants.imageURLPath) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        let fullURL = baseURL
            .appendingPathComponent(Constants.fileSize)
            .appendingPathComponent(posterPath)
        
        let (data, _) = try await session.data(from: fullURL)
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "Invalid Image Data", code: -1, userInfo: nil)
        }
        
        return image
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        guard let mainURL else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        let searchURL = mainURL.appending(path: Constants.searchPath)
        guard var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true) else {
            throw NSError(domain: "Invalid URL Components", code: -1, userInfo: nil)
        }
        
        components.queryItems = [
            URLQueryItem(name: QueryItem.API_KEY, value: Constants.API_KEY),
            URLQueryItem(name: QueryItem.query, value: query)
        ]
        
        guard let searchURL = components.url else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        let (data, _) = try await session.data(from: searchURL)
        let results = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        return results.movies
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        guard let mainURL else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        let popularURL = mainURL.appending(path: Constants.popularPath)
        guard var components = URLComponents(url: popularURL, resolvingAgainstBaseURL: true) else {
            throw NSError(domain: "Invalid URL Components", code: -1, userInfo: nil)
        }
        
        components.queryItems = [URLQueryItem(name: QueryItem.API_KEY, value: Constants.API_KEY)]
        
        guard let popularURL = components.url else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        let (data, _) = try await session.data(from: popularURL)
        let results = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        return results.movies
    }
}

