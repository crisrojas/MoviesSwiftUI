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
    var model: Movie { get set }
    func loadMovie()
    var error: NSError? { get set }
    var isLoading: Bool { get set }
}

class MovieDetailViewModel: ObservableObject, MovieDetailViewModelInput {
    
    @Published var model: Movie = .localMovie
    @Published var isLoading = false
    @Published var error: NSError?
    
    //private let movieService: MovieService
    private var movieRepository: MovieRepositoryInput
    private let movieId: Int
    
    // don't dare to use f*#*c8dfli#&g Singleton pattern in your vM repositories...
    init(movieId: Int, movieRepository: MovieRepositoryInput = MovieRepository()) {
        self.movieId = movieId
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadMovie() {

        self.isLoading = false
        self.movieRepository.fetchMovie(id: movieId)
    }
}


extension MovieDetailViewModel: MovieRepositoryOutput {
    func didRetrieveMovie(result: Result<Movie, MovieError>) {
        DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.model = movie
                    print("viewmodel: " + self.model.title)
                case .failure(let error):
                    self.error = error as NSError
        }
    }
}
}
