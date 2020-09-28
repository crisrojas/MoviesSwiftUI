//
//  File.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

struct DiscoverResponse: Decodable {
    let page, totalResults, totalPages: Int
    let results: [Movie]
}
