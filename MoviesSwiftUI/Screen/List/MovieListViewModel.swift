//
//  MovieListViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


// todo: Write protocol

protocol MovieListViewModelInput {
    //
}

class MovieListViewModel: ObservableObject {
    
    @Published var model: [Movie] = []
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var chunkedModel: [[Movie]] = []
    
    private let movieRepository : MovieRepositoryInput
    
    init(movieRepository: MovieRepositoryInput = MovieRepository.shared) {
        self.movieRepository = movieRepository
    }
    
    func loadMovies(with endpoint: MovieListEndpoint, currentItem: Int? = nil) {
        //self.model = nil
        self.isLoading = false
        self.movieRepository.fetchMovies(from: endpoint, currentItem: currentItem) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.model.append(contentsOf: response.results)
                self.chunkedModel = self.model.chunked(into: 2)
            case .failure(let error):
                self.error = error as NSError
                
            }
        }
    }
    
}
