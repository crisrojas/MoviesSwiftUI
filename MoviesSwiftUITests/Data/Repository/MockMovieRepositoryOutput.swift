//
//  MockMovieRepositoryOutput.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
@testable import MoviesSwiftUI

class MockMovieRepositoryOutput: MovieRepositoryOutput {
    
    var moviesModel: Result<MovieResponse, Error>?
    var genresModel: Result<GenresResponse, Error>?
    
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {
        moviesModel = result
    }
    
    func didRetrievePopular(result: Result<MovieResponse, Error>) {
        moviesModel = result
    }
    
    func didRetrieveTopRated(result: Result<MovieResponse, Error>) {
        moviesModel = result
    }
    
    func didRetrieveUpcoming(result: Result<MovieResponse, Error>) {
        moviesModel = result
    }
    
    func didRetrieveGenre(result: Result<MovieResponse, Error>) {
        moviesModel = result
    }
    
    func didRetrieveGenres(result: Result<GenresResponse, Error>) {
        genresModel = result
    }
}
