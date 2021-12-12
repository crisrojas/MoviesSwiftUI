//
//  ActorViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

// @todo: model shoulwd be CreditsResponse.person
final class ActorViewModel: ObservableObject {
  
    @Published var state: State = .idle
    
    enum State {
        case idle
        case loading
        case success(Person)
        case error(String)
    }
    
    private var repository: MovieRepositoryInput

    init(repository: MovieRepositoryInput = MovieRepository()) {
        self.repository = repository
        self.repository.output = self
    }
    
    func loadCredits(id: String) {
        self.repository.fetchCredits(id: id)
    }

}

extension ActorViewModel: MovieRepositoryOutput {
    
     func didRetrieveCredits(result: Result<CreditsResponse, Error>) {
        
        switch result {
        case .success(let response):
            
            guard let person = response.person else {
                state = .error("@error")
                return
            }
            
            state = .success(person)
            
        case .failure(_):
            
            state = .error("@error")
        }
    }
}
