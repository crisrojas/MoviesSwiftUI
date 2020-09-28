//
//  ActorViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


class ActorViewModel: ObservableObject {
   
    @Published var model: CreditsResponse?
    @Published var error: NSError?
    
    private var repository: MovieRepositoryInput
    private let creditId: String
    
    init(creditId: String, repository: MovieRepositoryInput = MovieRepository()) {
        self.creditId = creditId
        self.repository = repository
        self.repository.output = self
    }
    
    func loadCredits() {
        self.repository.fetchCredits(id: creditId)
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
