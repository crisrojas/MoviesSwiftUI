//
//  MovieSearchState.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

final class SearchScreenViewModel: ObservableObject {
    
    @Published var state: State = .idle
    @Published var query = ""
    
    enum State {
        case idle
        case loading
        case success([Movie])
        case error(String)
    }
    
    private var repository: MovieRepositoryInput
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: MovieRepositoryInput = MovieRepository()) {
        self.repository = repository
        self.repository.output = self
        
        $query
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchInput in
                guard let self = self else { return }
                self.search(query: searchInput)
            }
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        guard !query.isEmpty else { state = .idle; return }
        state = .loading
        repository.searchMovie(query: query)
    }
}

extension SearchScreenViewModel: MovieRepositoryOutput {
    
    func didRetrieveSearch(result: Result<MovieResponse, Error>) {
        
        switch result {
            
        case .success(let response):
            
            withAnimation(.default) {
                state = .success(response.results)
            }
            
        case .failure(_):
            state = .error("error toDo")
        }
    }
}
