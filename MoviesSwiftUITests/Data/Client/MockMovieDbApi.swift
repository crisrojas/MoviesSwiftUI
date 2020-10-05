//
//  MockMovieApi.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 30/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
@testable import MoviesSwiftUI

class MockMovieDbApi: MovieDbApi {
    
    var isGetTopRatedCalled = false
    var isGetUpcomingCalled = false
    var isGetPopularCalled = false
    var isGetNowPlayingCalled = false
    var isGetMovieCalled = false
    var isGetSearchCalled = false
    var isGetCreditsCalled = false
    var isGetGenresCalled = false
    var isGetGenreCalled = false
    
    var movieResponse: MovieResponse!
    var genresResponse: GenresResponse!
    var creditsResponse: CreditsResponse!
    var movie: Movie!
    
    
    var withError: Bool
    
    init(withError: Bool = false) {
        self.withError = withError
    }
    
    func getTopRated(completion: @escaping MovieCompletion<MovieResponse>) {
        isGetTopRatedCalled = true
        
        checkForMovieResponse(completion: completion)
    }
    
    func getUpcoming(completion: @escaping MovieCompletion<MovieResponse>) {
        isGetUpcomingCalled = true
        
        checkForMovieResponse(completion: completion)
    }
    
    func getPopular(page: Int, completion: @escaping MovieCompletion<MovieResponse>) {
        isGetPopularCalled = true
        
        checkForMovieResponse(completion: completion)
    }
    
    func getNowPlaying(page: Int, completion: @escaping MovieCompletion<MovieResponse>) {
        isGetNowPlayingCalled = true
        
        checkForMovieResponse(completion: completion)
    }
    
    func getMovie(id: Int, completion: @escaping MovieCompletion<Movie>) {
        isGetMovieCalled = true
        
        if withError {
            completion(.failure(.noData))
        } else {
            completion(.success(movie))
        }
    }
    
    func getSearch(query: String, completion: @escaping MovieCompletion<MovieResponse>) {
        isGetSearchCalled = true
        
        checkForMovieResponse(completion: completion)
    }
    
    func getCredits(id: String, completion: @escaping MovieCompletion<CreditsResponse>) {
        isGetCreditsCalled = true
        
        if withError {
            completion(.failure(.noData))
        } else {
            completion(.success(creditsResponse))
        }
    }
    
    func getGenres(completion: @escaping MovieCompletion<GenresResponse>) {
        isGetGenresCalled = true
        
        if withError {
            completion(.failure(.noData))
        } else {
            completion(.success(genresResponse))
        }
    }
    
    func getGenre(id: Int, page: Int, completion: @escaping MovieCompletion<MovieResponse>) {
        isGetGenreCalled = true
        
        checkForMovieResponse(completion: completion)
    }
    
    func checkForMovieResponse(completion: @escaping MovieCompletion<MovieResponse>) {
        if withError {
            completion(.failure(.noData))
        } else {
            completion(.success(movieResponse))
        }
    }
}


