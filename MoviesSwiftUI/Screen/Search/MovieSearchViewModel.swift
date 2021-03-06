//
//  MovieSearchState.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class MovieSearchViewModel: ObservableObject {
    
    @Published var query = ""
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    var movieRepository: MovieRepositoryInput
    init(movieRepository: MovieRepositoryInput = MovieRepository()) {
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func stateObserve() {
        guard subscriptionToken == nil else { return }
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                self?.movies = nil
                self?.error = nil
                return text
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.search(query: $0)}
    }
    
    func search(query: String) {
        self.movies = nil
        self.isLoading = false
        self.error = nil
        guard !query.isEmpty else {
            return
        }
        
        self.isLoading = true
        self.movieRepository.searchMovie(query: query) {[weak self] (result) in
            guard let self = self, self.query == query else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}

extension MovieSearchViewModel: MovieRepositoryOutput {
    func didRetrieveSearch(result: Result<MovieResponse, Error>) {
        self.isLoading = false
        switch result {
        case .success(let response):
            self.movies = response.results
        case .failure(let error):
            self.error = error as NSError
        }
    }
}
