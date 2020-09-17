//
//  MovieAPI.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


// Defintion of a typealias that we'll use in each func of the MovieAPI protocol


protocol MovieAPI {
    
}


class Api: MovieAPI {
    private let apiKey = "b5f1e193c3a2759a19f3f085f3dc2d7e"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    static let shared = Api()
    
    func getNowPlaying(page: Int? = 1, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(MovieListEndpoint.nowPlaying.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(for: page, url: url, completion: completion)
    }
    
    func getTopRated(completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(MovieListEndpoint.topRated.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func getPopular(completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(MovieListEndpoint.popular.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func getUpcoming(completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        
        guard let url = URL(string: "\(baseAPIURL)/movie/\(MovieListEndpoint.upcoming.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func getMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
        
    }
    
    private func loadURLAndDecode<D: Decodable>(for page: Int? = 1, url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        
        // If we can correctly access the url we continue, else we return an .invalidEndpoint
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        // We define a list of queryItems to append to the url (including the api_key)
        //        var pageString = "1"
        //        if let page = self.output?.page {
        //            pageString = String(page)
        //        }
        let page = String(page!)
        var queryItems = [URLQueryItem(name:"api_key", value: apiKey), URLQueryItem(name:"page", value: page)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        // We create the final url, if we got an error (nil) then we pass an .invalidEndpoint value to the completion
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        print(finalURL)
        decodeJSON(with: finalURL, completion: completion)
        
    }
    
    private func decodeJSON<D: Decodable>(with url: URL, completion: @escaping (Result<D, MovieError>) -> ()) {
        // We create a dataTask that will download the data from a url
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            // if Class is instantiated continue, else return
            guard let self = self else { return }
            // If there's an error execute a completion passing it a .apiiError and return
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            // If there's an httpError execute a completion passing it a .invalidResonse and return
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            // If there's that continue with the function, else execute completion passing it .noData
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            // Decode response throwing a serializating error if fail
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D,MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
            
        }
    }
    
}
