//
//  MovieDb.swift
//  MoviesSwiftUI
//
//  Created by cristian on 21/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
import Moya


enum MovieDb {
    
    static private let apiKey = "b5f1e193c3a2759a19f3f085f3dc2d7e"
    
    case topRated
    case upcoming
    case popular(page: Int)
    case nowPlaying(page: Int)
    case movie(id: Int)
    case search(query: String)
    case credit(id: String)
    case genres
    case genre(id: Int, page: Int)
}

extension MovieDb: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        case .popular:
            return "/movie/popular"
        case .nowPlaying:
            return "/movie/now_playing"
        case .movie(id: let id):
            return "/movie/\(id)"
        case .search:
            return "/search/movie"
        case .credit(id: let id):
            return "/credit/\(id)"
        case .genres:
            return "/genre/movie/list"
        case .genre:
            return "/discover/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topRated,
             .upcoming,
             .popular,
             .nowPlaying,
             .movie,
             .search,
             .credit,
             .genres,
             .genre:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .topRated:
            return .requestParameters(parameters: [
                "api_key": MovieDb.apiKey], encoding: URLEncoding.default)
        case .upcoming:
            return .requestParameters(parameters: [
                "api_key": MovieDb.apiKey], encoding: URLEncoding.default)
        case .popular(let page):
           return .requestParameters(parameters: [
            "api_key": MovieDb.apiKey,
            "page" : page], encoding: URLEncoding.default)
        case .nowPlaying(page: let page):
            
            return .requestParameters(parameters: [
                "api_key": MovieDb.apiKey,
                "page" : page], encoding: URLEncoding.default)
        case .movie(id: let id):
            return .requestParameters(parameters: [
                "api_key": MovieDb.apiKey,
                "id" : id,
                "append_to_response" : "videos,credits"], encoding: URLEncoding.default)
        case .search(query: let query):
            return .requestParameters(parameters: [
                "api_key": MovieDb.apiKey,
                "query" : query], encoding: URLEncoding.default)
        case .credit:
            return .requestParameters(parameters: [
                "api_key": MovieDb.apiKey,
                ],
                encoding: URLEncoding.default)
        case .genres:
            return .requestParameters(parameters: [
            "api_key": MovieDb.apiKey,
            ],
            encoding: URLEncoding.default)
        case .genre(id: let id, page: let page):
            return .requestParameters(parameters: [
                "api_key": MovieDb.apiKey,
                "with_genres": id,
                "page": page
                ],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}

