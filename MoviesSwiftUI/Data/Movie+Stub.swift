//
//  Movie+Stub.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


// We'll create two objects with local data from the resources/movie_list.json file
extension Movie {
    
    static var localMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var localMovie: Movie {
        localMovies[0]
    }
}


extension Bundle {
    /// Allows to decode a local file
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
              return nil
          }
          let data = try Data(contentsOf: url)
          let jsonDecoder = Utils.jsonDecoder
          let decodedModel = try jsonDecoder.decode(D.self, from: data)
          return decodedModel
    }
}
