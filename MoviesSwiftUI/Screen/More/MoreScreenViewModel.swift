//
//  MovieListViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import Foundation

final class MoreScreenViewModel: ObservableObject {
    
    // MARK: - State
    @Published var state: State = .idle
    
    enum State {
        case idle
        case loading
        case success(upcoming: [Movie], topRated: [Movie])
        case error(String)
    }
    
    // MARK: - Private Properties
    private var upcoming: [Movie]?
    private var topRated: [Movie]?
    
    private var movieRepository : MovieRepositoryInput
    
    init(movieRepository: MovieRepositoryInput = MovieRepository()) {
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadData() {
        
        state = .loading
        loadUpcoming()
        loadTopRated()
    }
    
    func loadUpcoming() {
        movieRepository.fetchUpcoming()
    }
    
    func loadTopRated() {
        movieRepository.fetchTopRated()
    }
    
}


// MARK: todo: implement MoviesRepositoryOutput protocol

extension MoreScreenViewModel: MovieRepositoryOutput {
    
    func didRetrieveUpcoming(result: Result<MovieResponse, Error>) {
        
        switch result {
            
        case .success(let response):
            upcoming = response.results
            updateState()
        case .failure(_):
            state = .error("Error toDo")
        }
    }
    
    func didRetrieveTopRated(result: Result<MovieResponse, Error>) {
        
        switch result {
        case .success(let response):
            topRated = response.results
            updateState()
        case .failure(_):
            state = .error("Error toDo")
        }
    }
    
    private func updateState() {
        
        guard
            let upcoming = upcoming,
            let topRated = topRated
        else { return }
        
        state = .success(
            upcoming: upcoming,
            topRated: topRated
        )
    }
}
