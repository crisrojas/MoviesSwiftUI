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
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchNowPlaying(page: Int?)
    func fetchUpcoming()
    func fetchTopRated()
    func fetchPopular()
    var output: MovieRepositoryOutput? { get set }
}

protocol MovieRepositoryOutput {
    func didRetrieveSearch(result: Result<MovieResponse, MovieError>)
    func didRetrieveNowPlaying(result: Result<MovieResponse, MovieError>)
    func didRetrieveTopRated(result: Result<MovieResponse, MovieError>)
    func didRetrieveUpcoming(result: Result<MovieResponse, MovieError>)
    func didRetrievePopular(result: Result<MovieResponse, MovieError>)
    func didRetrieveMovie(result: Result<Movie, MovieError>)
    
    
    
     func didRetrieveTopRatedWithMoya(result: Result<Response, MoyaError>)
}

extension MovieRepositoryOutput {
    func didRetrieveSearch(result: Result<MovieResponse, MovieError>) {}
    func didRetrieveNowPlaying(result: Result<MovieResponse, MovieError>) {}
    func didRetrieveTopRated(result: Result<MovieResponse, MovieError>) {}
    func didRetrieveUpcoming(result: Result<MovieResponse, MovieError>) {}
    func didRetrievePopular(result: Result<MovieResponse, MovieError>) {}
    func didRetrieveMovie(result: Result<Movie, MovieError>) {}
    
    
    
    func didRetrieveTopRatedWithMoya(result: Result<Response, MoyaError>) {}

}

class MovieRepository: MovieRepositoryInput {
    
    static let shared = MovieRepository()
    
    private let apiKey = "b5f1e193c3a2759a19f3f085f3dc2d7e"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    var output: MovieRepositoryOutput?
    
    private let api: MovieAPI
    private let provider = MoyaProvider<MovieDb>()
    
    init(api: Api = Api.shared) {
        self.api = api
    }
    
    func fetchNowPlaying(page: Int? = 1) {
        api.getNowPlaying(page: page) { (result) in
            self.output?.didRetrieveNowPlaying(result: result)
        }
    }
    
    func fetchUpcoming() {
        api.getUpcoming { (result) in
            self.output?.didRetrieveUpcoming(result: result)
        }
    }
    
    func fetchTopRated() {
        //
    }
    
    func fetchPopular() {
        self.api.getPopular { (result) in
            self.output?.didRetrievePopular(result: result)
        }
    }
    
    func fetchMovie(id: Int) {
        
        self.api.getMovie(id: id) { (result) in
            self.output?.didRetrieveMovie(result: result)
        }
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        self.api.getSearch(query: query) { (result) in
            self.output?.didRetrieveSearch(result: result)
        }
    }
    
}
