//
//  Movie.swift
//  MovieAPI
//
//  Created by KOДИ on 16.05.2024.
//

import Foundation

struct MovieResponse: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable {
    let id: Int
    let title, overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}
