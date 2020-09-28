//
//  GenresResponse.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String
}
