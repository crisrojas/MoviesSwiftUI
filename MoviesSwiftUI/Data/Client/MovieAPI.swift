//
//  MovieAPI.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import Foundation

protocol MovieAPI {
    func getNowPlaying(page: Int?, completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
    func getTopRated(completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
    func getPopular(completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
    func getUpcoming(completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
    func getMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func getSearch(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void)
}

protocol testApi {
    func getTopoRated(completion: @escaping (Result<MovieResponse, MoyaError>) -> Void)
}

extension MoyaProvider: testApi where Target == MovieDb {
    func getTopoRated(completion: @escaping (Result<MovieResponse, MoyaError>) -> Void) {
        request(.topRated) { result in
            //completion(result)
        }
    }
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
    
    func getSearch(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
                   completion(.failure(.invalidEndpoint))
                   return
               }
               
               self.loadURLAndDecode(url: url, params: [
                   "language": "en-US",
                   "include_adult": "false",
                   "region": "US",
                   "query": query
               ], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(for page: Int? = 1, url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
      
        let page = String(page!)
        var queryItems = [URLQueryItem(name:"api_key", value: apiKey), URLQueryItem(name:"page", value: page)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        print(finalURL)
        decodeJSON(with: finalURL, completion: completion)
        
    }
    
    private func decodeJSON<D: Decodable>(with url: URL, completion: @escaping (Result<D, MovieError>) -> ()) {
       
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            //
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            //
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            //
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
