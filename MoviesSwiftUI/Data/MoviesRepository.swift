//
//  MoviesRepository.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

protocol MoviesRepositoryOutput {
    func didDownloadMovies()
}

protocol MoviesRepositoryInput {
    func fetchMovies()
}

class MoviesRepository: MoviesRepositoryInput {
    
    let decoder = JSONDecoder()
    
    func fetchMovies() {
    
    }
}

