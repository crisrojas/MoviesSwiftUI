//
//  MovieCredits.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


struct MovieCredits: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}
