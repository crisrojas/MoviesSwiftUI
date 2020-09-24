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
    func fetchPopular()
    func fetchCredits(id: String)
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
}

extension MovieRepositoryOutput {
    func didRetrieveSearch(result: Result<MovieResponse, Error>) {}
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {}
    func didRetrieveTopRated(result: Result<MovieResponse, Error>) {}
    func didRetrieveUpcoming(result: Result<MovieResponse, Error>) {}
    func didRetrievePopular(result: Result<MovieResponse, Error>) {}
    func didRetrieveMovie(result: Result<Movie, Error>) {}
    func didRetrieveCredits(result: Result<CreditsResponse, Error>) {}
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
    
    func fetchPopular() {
        api.getPopular { (result) in
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
    
}
