//
//  MoviesMainViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

final class ListScreenViewModel: ObservableObject {
    
    @Published var state: State = .idle
    private var page: Int = 1
    
    enum State {
        case idle
        case loading
        case success(movies: [Movie], loadingMore: Bool)
        case error(String)
    }
    
    private var movieRepository: MovieRepositoryInput
    
    init(movieRepository: MovieRepositoryInput = MovieRepository()) {
        
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func initialLoad(endpoint: MovieListViewEndpoint) {
        
        state = .loading
        loadData(endpoint: endpoint)
    }
    
    func loadMoreItems(for endpoint: MovieListViewEndpoint) {
        
        if case let .success(movies, _) = state {
            state = .success(
                movies: movies,
                loadingMore: true
            )
            
            loadData(endpoint: endpoint)
        }
    }
}


// MARK: - Private methods

private extension ListScreenViewModel {
    
    func loadData(endpoint: MovieListViewEndpoint) {
        
        switch endpoint {
        case .popular:
            loadPopular()
        case .nowPlaying:
            loadNowPlaying()
        case .genre(let id):
            loadGenre(id: id)
        }
    }
    
    func loadGenre(id: Int) {
        movieRepository.fetchGenre(id: id, page: page)
    }
    
    func loadNowPlaying() {
        movieRepository.fetchNowPlaying(page: page)
    }
    
    func loadPopular() {
        movieRepository.fetchPopular(page: page)
    }
}


// MARK: RepositoryOutput methods
extension ListScreenViewModel: MovieRepositoryOutput {
    
    func didRetrieveGenre(result: Result<MovieResponse, Error>) {
        didRetrieveData(result: result)
    }
    
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {
        didRetrieveData(result: result)
    }
    
    func didRetrievePopular(result: Result<MovieResponse, Error>) {
        didRetrieveData(result: result)
    }
    
    private func didRetrieveData(result: Result<MovieResponse, Error>) {
        
        switch result {
            
        case .success(let response):
            
           
            if case let .success(movies, _) = state {
                state = .success(
                    movies: movies,
                    loadingMore: true
                )
                
                var newMovies = movies
                newMovies.append(contentsOf: response.results)
                
                state = .success(
                    movies: newMovies,
                    loadingMore: false
                )
                
               
            } else  {
             
                /// First load
                state = .success(
                    movies: response.results,
                    loadingMore: false
                )
            }

            self.page += 1
            
        case .failure(_):
            state = .error("toDo")
        }
    }
}
