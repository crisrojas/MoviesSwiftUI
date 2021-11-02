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
    func loadMovie(id: Int)
    var error: NSError? { get set }
    var isLoading: Bool { get set }
}

class MovieDetailViewModel: ObservableObject, MovieDetailViewModelInput {
    
    @Published var model: Movie = .mock
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var movieRepository: MovieRepositoryInput
//    private let movieId: Int
    
    
    init(movieRepository: MovieRepositoryInput = MovieRepository()) {
//        self.movieId = movieId
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadMovie(id: Int) {

        self.isLoading = false
        self.movieRepository.fetchMovie(id: id)
    }
}

extension MovieDetailViewModel: MovieRepositoryOutput {
    func didRetrieveMovie(result: Result<Movie, Error>) {
        switch result {
        case .success(let movie):
            self.model = movie
        case .failure(let error):
            self.error = error as NSError
        }
    }
}
