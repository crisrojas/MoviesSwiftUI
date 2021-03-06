//
//  MovieCrew.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

