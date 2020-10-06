//
//  Error.swift
//  MoviesSwiftUI
//
//  Created by cristian on 06/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


enum Error: Swift.Error {
    
    case apiError
    case networkError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
            
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        case .serializationError:
            return "Failed to decode data"
        case .networkError:
            return "Network Error"
        }
    }
}


