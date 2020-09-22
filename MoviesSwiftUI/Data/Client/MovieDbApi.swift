//
//  MovieDbAPI.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import Foundation

protocol MovieDbApi {
    func getTopRated(completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getUpcoming(completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getPopular(completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getNowPlaying(page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getMovie(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func getSearch(query: String, completion: @escaping (Result<MovieResponse, Error>) -> Void)
}

extension MoyaProvider: MovieDbApi where Target == MovieDb {
    
    func getPopular(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        request(.popular) { result in
            completion(result.mapResponse())
        }
    }
    
    func getNowPlaying(page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        request(.nowPlaying(page: page)) { result in
            completion(result.mapResponse())
        }
    }
    
    func getTopRated(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        request(.topRated) { result in
            completion(result.mapResponse())
        }
    }
    
    func getUpcoming(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
           request(.upcoming) { result in
               completion(result.mapResponse())
           }
       }
    func getMovie(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        request(.movie(id: id)) { result in
            completion(result.mapResponse())
        }
    }
    
    func getSearch(query: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        request(.search(query: query)) { result in
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

