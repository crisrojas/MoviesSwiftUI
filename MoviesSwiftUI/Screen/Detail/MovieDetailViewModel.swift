//
//  MovieDetailState.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

// todo: Write protocol
protocol MovieDetailViewModelInput {
    // rajouter movieId + movieRepository
    var model: Movie { get set }
    func loadMovie()
    var error: NSError? { get set }
    var isLoading: Bool { get set }
}

class MovieDetailViewModel: ObservableObject, MovieDetailViewModelInput {
    
    @Published var model: Movie = .mock
    @Published var isLoading = false
    @Published var error: NSError?
    
    //private let movieService: MovieService
    private var movieRepository: MovieRepositoryInput
    private let movieId: Int
    
    init(movieId: Int, movieRepository: MovieRepositoryInput = MovieRepository.shared) {
        self.movieId = movieId
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadMovie() {
        //elf.model = nil
        self.isLoading = false
        self.movieRepository.fetchMovie(id: movieId) { (result) in
            switch result {
            case .success(let movie):
                self.model = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}


extension MovieDetailViewModel: MovieRepositoryOutput {
    func didRetrieveMovie(result: Result<Movie, MovieError>) {
        switch result {
        case .success(let movie):
            self.model = movie
        case .failure(let error):
            self.error = error as NSError
    }
}
}
