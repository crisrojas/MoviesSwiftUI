//
//  ActorViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

protocol ActorViewModelInput {
    var model: CreditsResponse? { get set }
    func loadCredits()
}


class ActorViewModel: ObservableObject {
   
    @Published var model: CreditsResponse?
    @Published var error: NSError?
    
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
            self.model = response
        case .failure(let error):
            self.error = error as NSError
           
        }
    }
}
