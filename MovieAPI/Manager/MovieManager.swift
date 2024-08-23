//
//  MovieManager.swift
//  MovieAPI
//
//  Created by KOДИ on 01.07.2024.
//

import UIKit

actor MovieManager {
    
    private var popularMovies: [Movie] = []
    private var searchMovies: [Movie] = []
    private let network = NetworkManager.shared
    
    func fetchPopularMovies() async throws -> [Movie] {
        if popularMovies.isEmpty {
            popularMovies = try await network.fetchPopularMovies()
        }
        return popularMovies
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        if searchMovies.isEmpty {
            searchMovies = try await network.searchMovies(query: query)
        }
        return searchMovies
    }
}
