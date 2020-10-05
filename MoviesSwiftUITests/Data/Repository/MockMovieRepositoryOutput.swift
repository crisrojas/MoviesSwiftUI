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
    
    var movies: Result<MovieResponse, Error>?
    var genres: Result<GenresResponse, Error>?
    var movie: Result<Movie, Error>?
    var credits: Result<CreditsResponse, Error>?
    
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {
        movies = result
    }
    
    func didRetrievePopular(result: Result<MovieResponse, Error>) {
        movies = result
    }
    
    func didRetrieveTopRated(result: Result<MovieResponse, Error>) {
        movies = result
    }
    
    func didRetrieveUpcoming(result: Result<MovieResponse, Error>) {
        movies = result
    }
    
    func didRetrieveGenre(result: Result<MovieResponse, Error>) {
        movies = result
    }
    
    func didRetrieveGenres(result: Result<GenresResponse, Error>) {
        genres = result
    }
    
    func didRetrieveMovie(result: Result<Movie, Error>) {
        movie = result
    }
    
    func didRetrieveSearch(result: Result<MovieResponse, Error>) {
        movies = result
    }
    
    func didRetrieveCredits(result: Result<CreditsResponse, Error>) {
        credits = result
    }
}
