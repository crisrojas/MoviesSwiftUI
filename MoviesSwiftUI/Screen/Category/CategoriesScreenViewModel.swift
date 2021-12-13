//
//  GenresListViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

final class CategoriesScreenViewModel: ObservableObject {
    
    @Published var state: State = .idle

    enum State {
        case idle
        case loading
        case success([Genre])
        case error(String)
    }
    
    private var repository: MovieRepositoryInput
    
    init(repository: MovieRepositoryInput = MovieRepository()) {
        self.repository = repository
        self.repository.output = self
    }
    
    func loadGenres() {
        state = .loading
        self.repository.fetchGenres()
    }
}

extension CategoriesScreenViewModel: MovieRepositoryOutput {
    
    func didRetrieveGenres(result: Result<GenresResponse, Error>) {
        switch result {
        case .success(let response):
            state = .success(response.genres)
        case .failure(_):
            state = .error("Error toDo")
        }
    }
}
