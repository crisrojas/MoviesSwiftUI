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
    
    // Key
    static private let apiKey = "b5f1e193c3a2759a19f3f085f3dc2d7e"
    
    // Endpoints
    case topRated
}


extension MovieDb: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    
    var path: String {
        switch self {
        case .topRated: return "/top_rated"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topRated:
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
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}

