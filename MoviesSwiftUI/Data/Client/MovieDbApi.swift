//
//  MovieDbAPI.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import Foundation

typealias MovieCompletion<Response> = (_ result: Result<Response, Error>) -> Void

protocol MovieDbApi {
    func getTopRated(completion: @escaping MovieCompletion<MovieResponse>)
    func getUpcoming(completion: @escaping MovieCompletion<MovieResponse>)
    func getPopular(page: Int, completion: @escaping MovieCompletion<MovieResponse>)
    func getNowPlaying(page: Int, completion: @escaping MovieCompletion<MovieResponse>)
    func getMovie(id: Int, completion: @escaping MovieCompletion<Movie>)
    func getSearch(query: String, completion: @escaping MovieCompletion<MovieResponse>)
    func getCredits(id: String, completion: @escaping MovieCompletion<CreditsResponse>)
    func getGenres(completion: @escaping MovieCompletion<GenresResponse>)
    func getGenre(id: Int, page: Int, completion: @escaping MovieCompletion<DiscoverResponse>)
}

extension MoyaProvider: MovieDbApi where Target == MovieDb {
    
    func getPopular(page: Int, completion: @escaping MovieCompletion<MovieResponse>) {
        request(.popular(page: page)) { result in
            completion(result.mapResponse())
        }
    }
    
    func getNowPlaying(page: Int, completion: @escaping MovieCompletion<MovieResponse>) {
        request(.nowPlaying(page: page)) { result in
            completion(result.mapResponse())
        }
    }
    
    func getTopRated(completion: @escaping MovieCompletion<MovieResponse>) {
        request(.topRated) { result in
            completion(result.mapResponse())
        }
    }
    
    func getUpcoming(completion: @escaping MovieCompletion<MovieResponse>) {
           request(.upcoming) { result in
               completion(result.mapResponse())
           }
       }
    func getMovie(id: Int, completion: @escaping MovieCompletion<Movie>) {
        request(.movie(id: id)) { result in
            completion(result.mapResponse())
        }
    }
    
    func getSearch(query: String, completion: @escaping MovieCompletion<MovieResponse>) {
        request(.search(query: query)) { result in
            completion(result.mapResponse())
        }
    }
    
    func getCredits(id: String, completion: @escaping MovieCompletion<CreditsResponse>) {
        request(.credit(id: id)) { result in
            completion(result.mapResponse())
        }
    }
    
    func getGenres(completion: @escaping MovieCompletion<GenresResponse>) {
        request(.genres) { result in
            completion(result.mapResponse())
        }
   }
    
    func getGenre(id: Int, page: Int, completion: @escaping MovieCompletion<DiscoverResponse>) {
        request(.genre(id: id, page: page)) { result in
            completion(result.mapResponse())
        }
    }
}

//todo: implementer correctement
extension Result where Success == Moya.Response, Failure == MoyaError {
    func mapResponse<Object: Decodable>() -> Result<Object, Error> {
        switch self {
        case .success(let response):
            do {
                let object: Object = try response.map(Object.self, using: Utils.jsonDecoder)
                return .success(object)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            let error = error
            return .failure(error)
        }
    }
}

