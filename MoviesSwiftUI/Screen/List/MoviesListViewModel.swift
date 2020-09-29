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

enum MoviesListState {
    case loading, success, error
    var isLoading: Bool {
        self == .loading
    }
}


class MoviesListViewModel: ObservableObject {
    
    @Published var model: [Movie] = []
    @Published var genres: [Genre] = []
    @Published var isLoading = false
    @Published var error: NSError?
    
    
    //private var endpoint: String?
    private var page: Int = 1
    private var currentlyLoading: Bool = false
    
    private var movieRepository: MovieRepositoryInput
    
    init(movieRepository: MovieRepositoryInput = MovieRepository()) {
        self.movieRepository = movieRepository
        self.movieRepository.output = self
    }
    
    func loadGenres() {
        self.movieRepository.fetchGenres()
    }
    
    func loadGenre(id: Int, currentItem: Int? = nil) {
        if !shouldLoad(currentItem: currentItem) {
            return
        }
        
        self.movieRepository.fetchGenre(id: id, page: page)
    }
    
    func loadMovies(endpoint: String? = nil, currentItem: Int? = nil) {
        switch endpoint {
        case "nowPlaying":
            loadNowPlaying(currentItem: currentItem)
        case "popular":
            loadPopular(currentItem: currentItem)
        case nil: do {
            loadPopular(currentItem: currentItem)
        }
        default:
            break
        }
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
    
    private func shouldLoad(currentItem: Int?) -> Bool {
        if currentlyLoading {
            return false
        }
        
        guard let currentItem = currentItem else { return true }
        guard let lastItem = model.last else { return true }
        
        return currentItem == lastItem.id
    }
    
}

extension MoviesListViewModel: MovieRepositoryOutput {
    func didRetrieveGenres(result: Result<GenresResponse, Error>) {
        switch result {
        case .success(let response):
            self.genres = response.genres
        case .failure(let error):
            self.error = error as NSError
            print(error)
        }
    }
    func didRetrieveGenre(result: Result<DiscoverResponse, Error>) {
        switch result {
        case .success(let response):
            self.model.append(contentsOf: response.results)
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
    
    private func didRetrieveData(result: Result<MovieResponse, Error>) {
        switch result {
        case .success(let response):
            self.model.append(contentsOf: response.results)
            self.page += 1
        case .failure(let error):
            self.error = error as NSError
            print(error)
        }
    }
}
