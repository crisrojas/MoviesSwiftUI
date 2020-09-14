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
    var movie: Movie? { get set }
    func loadMovie()
    var error: NSError? { get set }
    var isLoading: Bool { get set }
}

class MovieDetailViewModel: ObservableObject, MovieDetailViewModelInput {
    
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    //private let movieService: MovieService
    private let movieRepository: MovieRepositoryInput
    private let movieId: Int
    
    init(movieId: Int, movieRepository: MovieRepositoryInput = MovieRepository.shared) {
        self.movieRepository = movieRepository
        self.movieId = movieId
    }
    
    func loadMovie() {
        self.movie = nil
        self.isLoading = false
        self.movieRepository.fetchMovie(id: movieId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}


