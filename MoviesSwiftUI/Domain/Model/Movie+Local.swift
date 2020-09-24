//
//  Movie+Stub.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


// We'll create two objects with local data from the resources/movie_list.json file
extension Movie {
    
    static var localMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var localMovie: Movie {
        localMovies[0]
    }
    
     static let mock = Movie(id: -1, title: "", backdropPath: "", posterPath: "", overview: "", voteAverage: 0.0, voteCount: 0, runtime: 0, releaseDate: "", genres: nil, credits: nil, videos: nil, originalLanguage: "")
}
