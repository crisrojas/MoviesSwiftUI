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
    //
    
}

class MovieDetailViewModel: ObservableObject {
    
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError? // optional because every variable should be initialized
    
    //private let movieService: MovieService
    private let movieRepository: MovieRepositoryInput
    
    init(movieRepository: MovieRepositoryInput = MovieRepository.shared) {
        self.movieRepository = movieRepository
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieRepository.fetchMovie(id: id) { [weak self] (result) in
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
