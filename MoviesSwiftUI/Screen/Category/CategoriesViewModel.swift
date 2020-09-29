//
//  GenresListViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    
    @Published var model: [Genre]?
    
    private var repository: MovieRepositoryInput
    
    init(repository: MovieRepositoryInput = MovieRepository()) {
        self.repository = repository
        self.repository.output = self
    }
    
    func loadGenres() {
        self.repository.fetchGenres()
    }
}

extension CategoriesViewModel: MovieRepositoryOutput {
    func didRetrieveGenres(result: Result<GenresResponse, Error>) {
        switch result {
        case .success(let response):
            self.model = response.genres
        case .failure(let error):
            print(error)
        }
    }
}
