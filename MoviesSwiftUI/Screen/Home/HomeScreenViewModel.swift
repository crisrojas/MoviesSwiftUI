//
//  MoviesHomeViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


class HomeScreenViewModel: ObservableObject {
    
    // MARK: - State
    @Published var state: State = .idle
    
    enum State {
        case idle
        case loading
        case success(popular: [Movie], nowPlaying: [Movie])
        case error(String)
    }
    
    // MARK: - Properties
    private var popularMovies: [Movie]?
    private var nowPlayingMovies: [Movie]?
    
    // MARK: - Dependencies
    private var repository: MovieRepositoryInput
    
    // @todo: Use library to inject dependencies
    init(repository: MovieRepositoryInput = MovieRepository()) {
        self.repository = repository
        self.repository.output = self
    }
    
    func loadData() {
        state = .loading
        loadPopular()
        loadNowPlaying()
    }
    
    private func loadPopular() {
        self.repository.fetchPopular(page: 1)
    }
    
    private func loadNowPlaying() {
        self.repository.fetchNowPlaying(page: 1)
    }
}

extension HomeScreenViewModel: MovieRepositoryOutput {
    
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {
        
        switch result {
        case .success(let response):
            self.nowPlayingMovies = response.results
            updateState()
        case .failure(_):
            state = .error("@todo")
        }
        
    }
    
    func didRetrievePopular(result: Result<MovieResponse, Error>) {
        
        switch result {
        case .success(let response):
            self.popularMovies = response.results
            updateState()
        case .failure(_):
            state = .error("@todo")
        }
    }
    
    private func updateState() {
        
        guard
            let now = nowPlayingMovies,
            let popular = popularMovies
        else { return }
        
        state = .success(popular: now, nowPlaying: popular)
    }
}
