//
//  MovieTests.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 30/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class MovieTests: XCTestCase {
    
    func testDecodable() {
        let movieList = Movie.localMovies
        let firstMovie = movieList.first
        XCTAssertEqual(movieList.count, 20)
        XCTAssertEqual(firstMovie?.title, "Bloodshot")   
    }


}
