//
//  MoviesMainViewModel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

protocol MoviesListViewModelInput {
    var model: [Movie] { get set }
}

enum MoviesListViewState {
    case loading, success, error
    var isLoading: Bool {
        self == .loading
    }
}

protocol MoviesListVMOutput {
    func didUpdate(state: MoviesListViewState)
}

class MoviesListViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var genres: [Genre] = []
    @Published var isLoading = false
    @Published var error: NSError?
    //let view: MoviesListVMOutput
    
    //private var endpoint: String?
    private var page: Int = 1
    private var currentlyLoading: Bool = false
    
    private var movieRepository: MovieRepositoryInput
    
    init(/*todo: view: MoviesListVMOutput, */movieRepository: MovieRepositoryInput = MovieRepository()) {
        
        print("Instance of MoviesListViewModel created")
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    deinit {
        print("Instance of MovieListViewModel deleted")
    }
    
    func loadGenre(id: Int, currentItem: Int? = nil) {
        if !shouldLoad(currentItem: currentItem) {
            return
        }
        
        self.movieRepository.fetchGenre(id: id, page: page)
    }

    func loadNowPlaying(currentItem: Int? = nil) {
        if !shouldLoad(currentItem: currentItem) {
            return
        }
        
        self.isLoading = false
        self.movieRepository.fetchNowPlaying(page: page)
    }
    
    func loadPopular(currentItem: Int? = nil) {
        if !shouldLoad(currentItem: currentItem) {
                   return
               }
               
         self.isLoading = false
        self.movieRepository.fetchPopular(page: page)
    }
}


// MARK: RepositoryOutput methods
extension MoviesListViewModel: MovieRepositoryOutput {
    
    func didRetrieveGenre(result: Result<MovieResponse, Error>) {
        switch result {
        case .success(let response):
            self.movies.append(contentsOf: response.results)
            self.page += 1
        case .failure(let error):
            print(error)
        }
    }
    func didRetrieveNowPlaying(result: Result<MovieResponse, Error>) {
        didRetrieveData(result: result)
    }
    func didRetrievePopular(result: Result<MovieResponse, Error>) {
        didRetrieveData(result: result)
    }
}


// MARK: Private methods
private extension MoviesListViewModel {
    
     func shouldLoad(currentItem: Int?) -> Bool {
        if currentlyLoading {
            return false
        }
        
        guard let currentItem = currentItem else { return true }
        guard let lastItem = movies.last else { return true }
        
        return currentItem == lastItem.id
    }
    
    private func didRetrieveData(result: Result<MovieResponse, Error>) {
        switch result {
        case .success(let response):
            self.movies.append(contentsOf: response.results)
            self.page += 1
        case .failure(let error):
            self.error = error as NSError
            print(error)
        }
    }
}
