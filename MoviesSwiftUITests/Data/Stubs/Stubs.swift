//
//  LocalData.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//


import XCTest
@testable import MoviesSwiftUI


class Stubs {
    
    static var genres: [Genre] {
        let response: GenresResponse? = try? Bundle.loadData(filename: "genres")
        return response!.genres
    }
    
    static var movies: [Movie] {
        let response: MovieResponse? = try? Bundle.loadData(filename: "movie_list")
        return response!.results
    }
    
    static var movie: Movie {
        let movie = movies[0]
        return movie
    }
}
