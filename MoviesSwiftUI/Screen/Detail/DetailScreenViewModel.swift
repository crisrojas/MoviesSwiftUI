//
//  MovieDetailState.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


final class DetailScreenViewModel: ObservableObject {
    
    @Published var state: State = .idle
    
    enum State {
        case idle
        case loading
        case success(Movie)
        case error(String)
    }
    
    private var movieRepository: MovieRepositoryInput

    
    
    init(movieRepository: MovieRepositoryInput = MovieRepository()) {
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadMovie(id: Int) {

        state = .loading
        self.movieRepository.fetchMovie(id: id)
    }
}

extension DetailScreenViewModel: MovieRepositoryOutput {
    
    func didRetrieveMovie(result: Result<Movie, Error>) {
        switch result {
        case .success(let movie):
            state = .success(movie)
        case .failure(_):
            state = .error("@todo")
        }
    }
    
}
