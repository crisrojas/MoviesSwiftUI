//
//  MovieSearchViewModelTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class MovieSearchViewModelTestCase: XCTestCase {

    func testGivenThatMoviesIsNil_WhenCallingSearchWithNonEmptyQuery_ThenMoviesShouldntBeNil() {
        let repository = MockMovieRepository()
        let vm = MovieSearchViewModel(movieRepository: repository)
         
        vm.search(query: "non empty query")
        XCTAssertTrue(vm.movies != nil)
    }
    
    func testGivenThatMoviesIsNil_WhenCallingSearchWithEmptyQuery_ThenMoviesShouldBeNil() {
        let repository = MockMovieRepository()
        let vm = MovieSearchViewModel(movieRepository: repository)
        
        vm.search(query: "")
        XCTAssertTrue(vm.movies == nil)
    }
}
