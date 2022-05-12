//
//  MovieSearchResponse.swift
//  MovieIt
//
//  Created by 효우 on 2022/05/10.
//

import Foundation

struct MovieSearchResponse: Decodable {
    var resultCount: Int
    var results: [results]
}

struct results: Decodable {
    var trackName: String
    var releaseDate: String
    var artworkUrl100: String
    var previewUrl: String
    var longDescription: String
}
