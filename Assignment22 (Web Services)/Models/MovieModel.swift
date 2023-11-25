//
//  MovieModel.swift
//  Assignment22 (Web Services)
//
//  Created by Macbook Air 13 on 25.11.23.
//

import Foundation

struct MovieResponseDataModel: Decodable {
    
    let results: [MovieModel]
}

struct MovieModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
