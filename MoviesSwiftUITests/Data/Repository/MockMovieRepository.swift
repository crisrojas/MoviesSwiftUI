//
//  MockMovieRepository.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 30/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
@testable import MoviesSwiftUI

class MockMovieRepository: MovieRepositoryInput {
    weak var output: MovieRepositoryOutput?
    
    var withError: Bool
    init(withError: Bool = false) {
        self.withError = withError
    }
    
    func fetchMovie(id: Int) {
        if withError {
            output?.didRetrieveMovie(result: .failure(.noData))
        } else {
            output?.didRetrieveMovie(result: .success(Movie.localMovie))
        }
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, Error>) -> ()) {
        if withError {
            output?.didRetrieveSearch(result: .failure(.noData))
        } else {
            output?.didRetrieveSearch(result: .success(MovieResponse(results: Stubs.movies)))
        }
    }
    
    func fetchNowPlaying(page: Int?) {
        if withError {
            output?.didRetrieveNowPlaying(result: .failure(.noData))
        } else {
            output?.didRetrieveNowPlaying(result: .success(MovieResponse(results: Stubs.movies)))
        }
    }
    
    func fetchUpcoming() {
        if withError {
            output?.didRetrieveUpcoming(result: .failure(.noData))
        } else {
            output?.didRetrieveUpcoming(result: .success(MovieResponse(results: Stubs.movies)))
        }
    }
    
    func fetchTopRated() {
        if withError {
            output?.didRetrieveTopRated(result: .failure(.noData))
        } else {
            output?.didRetrieveTopRated(result: .success(MovieResponse(results: Stubs.movies)))
        }
    }
    
    func fetchPopular(page: Int?) {
        if withError {
            output?.didRetrievePopular(result: .failure(.noData))
        } else {
            output?.didRetrievePopular(result: .success(MovieResponse(results: Stubs.movies)))
        }
        
    }
    
    func fetchCredits(id: String) {
        if withError {
            output?.didRetrieveCredits(result: .failure(.noData))
        } else {
            output?.didRetrieveCredits(result: .success(Stubs.credits))
        }
    }
    
    func fetchGenres() {
        if withError {
            output?.didRetrieveGenres(result: .failure(.noData))
        } else {
            output?.didRetrieveGenres(result: .success(GenresResponse(genres: Stubs.genres)))
        }
    }
    
    func fetchGenre(id: Int, page: Int?) {
        if withError {
            output?.didRetrieveGenre(result: .failure(.noData))
        } else {
            output?.didRetrieveGenre(result: .success(MovieResponse(results: Stubs.movies)))
        }
    }
    
}
