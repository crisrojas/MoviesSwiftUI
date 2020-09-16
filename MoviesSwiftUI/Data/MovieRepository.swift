//
//  MovieServices.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

// MovieRepository.swift


protocol MovieRepositoryInput {
    func fetchMovies(from endpoint: MovieListEndpoint, currentItem: Int?, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

class MovieRepository: MovieRepositoryInput {
    
    static let shared = MovieRepository()
    private init() {}
    
    private let apiKey = "b5f1e193c3a2759a19f3f085f3dc2d7e"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    private var output: MovieListViewModel?
    private var page = 1
    private var currentlyLoading = false

    
    // Fetch movies
    func fetchMovies(from endpoint: MovieListEndpoint, currentItem: Int?, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        
        if !shouldLoad(currentItem: currentItem) {
            return
        }
        
        currentlyLoading = true
        
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        
        guard let url = URL(string: "\(baseAPIURL)/movie/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
     
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include adult": "false",
            "region": "US",
            "query": query
        ], completion: completion)
    }
    
    private func shouldLoad(currentItem: Int?) -> Bool {
        if currentlyLoading {
            return false
        }
        guard let currentItem = currentItem else { return true }
        guard let lastItem = output?.model.last else { return true }
        
        return currentItem == lastItem.id
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        
        // If we can correctly access the url we continue, else we return an .invalidEndpoint
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        // We define a list of queryItems to append to the url (including the api_key)
        let pageString = String(page)
        var queryItems = [URLQueryItem(name:"api_key", value: apiKey), URLQueryItem(name:"page", value: pageString)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        // We create the final url, if we got an error (nil) then we pass an .invalidEndpoint value to the completion
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        decodeJSON(with: finalURL, completion: completion)
        
    }
    
    private func decodeJSON<D: Decodable>(with url: URL, completion: @escaping (Result<D, MovieError>) -> ()) {
        // We create a dataTask that will download the data from a url
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            // if Class is instantiated continue, else return
            guard let self = self else { return }
            // If there's an error execute a completion passing it a .apiiError and return
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), loading: false, completion: completion)
                return
            }
            // If there's an httpError execute a completion passing it a .invalidResonse and return
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), loading: false, completion: completion)
                return
            }
            // If there's that continue with the function, else execute completion passing it .noData
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), loading: false, completion: completion)
                return
            }
            
            // Decode response throwing a serializating error if fail
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), loading: false, completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), loading: false, completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D,MovieError>, loading: Bool, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
            self.page += 1
            self.currentlyLoading = loading
            
        }
    }
}
