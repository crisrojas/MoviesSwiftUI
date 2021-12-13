//
//  MoviesHomeViewModelTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 30/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class MoviesHomeViewModelTestCase: XCTestCase {

    var repository: MockMovieRepository!
    var vm: HomeScreenViewModel!
    
    override func setUp() {
       super.setUp()
       repository = MockMovieRepository()
       vm = HomeScreenViewModel(repository: repository)
    }

   
    // Test loadPopular()
    func testGivenMoviesAreEmpty_WhenCallingFetchPopular_ThenMoviesAreFilled() {
        vm.loadPopular()
        
        XCTAssertFalse(vm.movies.isEmpty)
    }
    
    func testGivenMoviesAreEmpty_WhenCallingFetchPopularWithError_ThenMoviesAreEmpty() {
        repository.withError = true
        vm.loadPopular()
        
        XCTAssertTrue(vm.movies.isEmpty)
    }
    
    // Tests loadNowPlaying()
    func testGivenMoviesAreEmpty_WhenCallingFetchNowPlaying_ThenMoviesAreFilled() {
        vm.loadNowPlaying()
    
        XCTAssertFalse(vm.movies.isEmpty)
    }
    
    func testGivenMoviesAreEmpty_WhenCallingFetchNowPlayingWithErros_ThenMoviesAreEmpty() {
        repository.withError = true
        vm.loadNowPlaying()
        
        XCTAssertTrue(vm.movies.isEmpty)
    }
}
