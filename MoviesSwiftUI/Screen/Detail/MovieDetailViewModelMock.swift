//
//  MovieDetailViewModelMock.swift
//  MoviesSwiftUI
//
//  Created by cristian on 14/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


class MovieDetailViewModelMock: MovieDetailViewModelInput {

    
    var movie: Movie?
    
    private let movieRepository: MovieRepositoryInput
    private let movieId: Int
    
    // Not necessary for the mock since all data is loaded locally? but necessary for the views
    var error: NSError?
    var isLoading: Bool = false
    
    init(movieId: Int, movieRepository: MovieRepositoryInput = MovieRepository.shared) {
        self.movieId = movieId
        self.movieRepository = movieRepository
    }
    
    func loadMovie() {
        self.movie = Movie.localMovie
    }
}
