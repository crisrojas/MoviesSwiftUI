//
//  MovieListViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import Foundation

// todo: Write protocol
protocol MovieListViewModelInput {}

class MoviesMoreViewModel: ObservableObject {
    
    @Published var model: [Movie] = []
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var movieRepository : MovieRepositoryInput
    
    init(movieRepository: MovieRepositoryInput = MovieRepository()) {
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadUpcoming() {
        self.model = [ ]
        self.isLoading = false
        self.movieRepository.fetchUpcoming()
    }
    
    func loadTopRated() {
        self.model = [ ]
        self.isLoading = false
        self.movieRepository.fetchTopRated()
    }
    
}


// MARK: todo: implement MoviesRepositoryOutput protocol

extension MoviesMoreViewModel: MovieRepositoryOutput {
    
    func didRetrieveUpcoming(result: Result<MovieResponse, Error>) {
        didRetrieveMovies(result: result)
    }
    
    func didRetrieveTopRated(result: Result<MovieResponse, Error>) {
        didRetrieveMovies(result: result)
    }
    
    private func didRetrieveMovies(result: Result<MovieResponse, Error>) {
        self.isLoading = false
        switch result {
        case .success(let response):
            self.model = response.results
        case .failure(let error):
            self.error = error as NSError
        }
    }
}
