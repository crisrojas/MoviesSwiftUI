//
//  MovieListState.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
import SwiftUI

// todo: Write protocol

protocol MovieListViewModelInput {
    //
}

class MovieListViewModel: ObservableObject {
    
    @Published var model: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieRepository : MovieRepositoryInput
    
    init(movieRepository: MovieRepositoryInput = MovieRepository.shared) {
        self.movieRepository = movieRepository
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) {
        self.model = nil
        self.isLoading = false
        self.movieRepository.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.model = response.results
            case .failure(let error):
                self.error = error as NSError
                
            }
        }
    }
}

struct MovieListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
