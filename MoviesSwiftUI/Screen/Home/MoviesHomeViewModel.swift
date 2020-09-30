//
//  MoviesHomeViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


class MoviesHomeViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var genres: [Genre] = []
    
    private var repository: MovieRepositoryInput
    
    init(repository: MovieRepositoryInput = MovieRepository()) {
        self.repository = repository
        self.repository.output = self
    }
    
    func loadPopular() {
        self.repository.fetchPopular(page: 1)
    }
    
    func loadNowPlaying() {
        self.repository.fetchNowPlaying(page: 1)
    }
}

extension MoviesHomeViewModel: MovieRepositoryOutput {
   func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {
        didRetrieveList(result: result)
    }
    func didRetrievePopular(result: Result<MovieResponse, Error>) {
        didRetrieveList(result: result)
    }
    
    private func didRetrieveList(result: Result<MovieResponse, Error>) {
        switch result {
        case .success(let response):
            self.movies = response.results
        case .failure(let error):
            print(error)
        }
    }
}
