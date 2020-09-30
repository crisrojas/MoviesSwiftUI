//
//  MoviesListViewModelTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class MoviesListViewModelTestCase: XCTestCase {

    func testGivenModelIsEmpty_WhenCallingLoadNowPlaying_ThenModelShouldnBeEmpty() {
        let repository = MockMovieRepository()
        let vm = MoviesListViewModel(movieRepository: repository)
        
        vm.loadPopular()
        
        XCTAssertFalse(vm.movies.isEmpty)
    }
    
    func testGivenModelIsEmpty_WhenCallingLoadPopular_ThenModelShouldntBeEmpty() {
        let repository = MockMovieRepository()
        let vm = MoviesListViewModel(movieRepository: repository)
        
        vm.loadPopular()
        
        XCTAssertFalse(vm.movies.isEmpty)
    }
}
