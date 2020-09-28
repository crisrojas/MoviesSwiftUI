//
//  MoviesMainViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

protocol MoviesMainViewModelInput {
    var model: [Movie] { get set }
}

class MoviesMainViewModel: ObservableObject, MoviesMainViewModelInput {
    
    @Published var model: [Movie] = []
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var endpoint: String
    private var page: Int = 1
    private var currentlyLoading: Bool = false
    
    enum Endpoint {
        case nowPlaying, popular
    }
    
    private var movieRepository: MovieRepositoryInput
    
    init(endpoint: String, movieRepository: MovieRepositoryInput = MovieRepository()) {
        self.endpoint = endpoint
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadMovies() {
        switch self.endpoint {
            
        case "nowPlaying":
            loadNowPlaying()
        case "popular":
            loadPopular()
        default:
            break
        }
    }
    
    /// Loads now playing.
    /// Current item is used to check if list item is last (necessary for infinite scrolling)
    func loadNowPlaying(currentItem: Int? = nil) {
        if !shouldLoad(currentItem: currentItem) {
            return
        }
        
        self.isLoading = false
        self.movieRepository.fetchNowPlaying(page: page)
    }
    
    func loadPopular() {
        self.movieRepository.fetchPopular()
    }
    
    private func shouldLoad(currentItem: Int?) -> Bool {
        if currentlyLoading {
            return false
        }
        
        guard let currentItem = currentItem else { return true }
        guard let lastItem = model.last else { return true }
        
        return currentItem == lastItem.id
    }
}

extension MoviesMainViewModel: MovieRepositoryOutput {
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {
        didRetrieveData(result: result)
    }
    func didRetrievePopular(result: Result<MovieResponse, Error>) {
        didRetrieveData(result: result)
    }
    
    private func didRetrieveData(result: Result<MovieResponse, Error>) {
        switch result {
        case .success(let response):
            self.model.append(contentsOf: response.results)
            self.page += 1
        case .failure(let error):
            self.error = error as NSError
            print(error)
        }
    }
}
