//
//  MovieCast.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

struct MovieCast: Decodable, Identifiable, Equatable {
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
    let gender: Int?
    let creditId: String?
    
    var profileURL: String? {
        guard let profilePath = profilePath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(profilePath)"
    }
}
