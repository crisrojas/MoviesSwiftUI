//
//  MovieServices.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
import Moya

protocol MovieRepositoryInput {
    func fetchMovie(id: Int)
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, Error>) -> ())
    func fetchNowPlaying(page: Int?)
    func fetchUpcoming()
    func fetchTopRated()
    func fetchPopular(page: Int?)
    func fetchCredits(id: String)
    func fetchGenres()
    func fetchGenre(id: Int, page: Int?)
    var output: MovieRepositoryOutput? { get set }
}

protocol MovieRepositoryOutput: class {
    func didRetrieveSearch(result: Result<MovieResponse, Error>)
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>)
    func didRetrieveTopRated(result: Result<MovieResponse, Error>)
    func didRetrieveUpcoming(result: Result<MovieResponse, Error>)
    func didRetrievePopular(result: Result<MovieResponse, Error>)
    func didRetrieveMovie(result: Result<Movie, Error>)
    func didRetrieveCredits(result: Result<CreditsResponse, Error>)
    func didRetrieveGenres(result: Result<GenresResponse, Error>)
    func didRetrieveGenre(result: Result<DiscoverResponse, Error>)
}

extension MovieRepositoryOutput {
    func didRetrieveSearch(result: Result<MovieResponse, Error>) {}
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {}
    func didRetrieveTopRated(result: Result<MovieResponse, Error>) {}
    func didRetrieveUpcoming(result: Result<MovieResponse, Error>) {}
    func didRetrievePopular(result: Result<MovieResponse, Error>) {}
    func didRetrieveMovie(result: Result<Movie, Error>) {}
    func didRetrieveCredits(result: Result<CreditsResponse, Error>) {}
    func didRetrieveGenres(result: Result<GenresResponse, Error>) {}
    func didRetrieveGenre(result: Result<DiscoverResponse, Error>) {}
}

class MovieRepository: MovieRepositoryInput {
    
    weak var output: MovieRepositoryOutput?
    
    private let api = MoyaProvider<MovieDb>()
    
    func fetchNowPlaying(page: Int? = 1) {
        api.getNowPlaying(page: page!) { (result) in
            self.output?.didRetrieveNowPlaying(result: result)
        }
    }
    
    func fetchUpcoming() {
        api.getUpcoming { (result) in
            self.output?.didRetrieveUpcoming(result: result)
        }
    }
    
    func fetchTopRated() {
        api.getTopRated { (result) in
            self.output?.didRetrieveTopRated(result: result)
        }
    }
    
    func fetchPopular(page: Int? = 1) {
        api.getPopular(page: page!) { (result) in
            self.output?.didRetrievePopular(result: result)
        }
    }
    
    func fetchMovie(id: Int) {
        api.getMovie(id: id) { (result) in
            self.output?.didRetrieveMovie(result: result)
        }
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, Error>) -> ()) {
        api.getSearch(query: query) { (result) in
            self.output?.didRetrieveSearch(result: result)
        }
    }
    
    func fetchCredits(id: String) {
        api.getCredits(id: id) { (result) in
            self.output?.didRetrieveCredits(result: result)
        }
    }
    
    func fetchGenres() {
        api.getGenres { (result) in
            self.output?.didRetrieveGenres(result: result)
        }
    }
    
    func fetchGenre(id: Int, page: Int? = 1) {
        api.getGenre(id: id, page: page!) { (result) in
            self.output?.didRetrieveGenre(result: result)
        }
    }
}
