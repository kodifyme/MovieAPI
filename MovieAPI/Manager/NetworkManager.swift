//
//  NetworkManager.swift
//  MovieAPI
//
//  Created by KOДИ on 20.05.2024.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let API_KEY = "a5437d346e782df5011c4a6fc09611da"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchPopularMovies(complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/movie/popular?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    complition(.failure(error))
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(error))
            }
        }
        task.resume()
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
