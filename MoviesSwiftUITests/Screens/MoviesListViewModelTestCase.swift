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

    func testGivenMoviesArrayIsEmpty_WhenCallingLoadNowPlaying_ThenMoviesArrayShouldntBeEmpty() {
        let repository = MockMovieRepository()
        let vm = ListScreenViewModel(movieRepository: repository)
        
        vm.loadNowPlaying()
        
        XCTAssertFalse(vm.movies.isEmpty)
    }
    
    func testGivenMoviesArrayIsEmpty_WhenCallingLoadNowPlayingWithError_ThenMoviesArrayShouldBeEmpty() {
        let repository = MockMovieRepository()
        let vm = ListScreenViewModel(movieRepository: repository)
        
        repository.withError = true
        
        vm.loadNowPlaying()
        
        XCTAssertTrue(vm.movies.isEmpty)
    }
    
    func testGivenMoviesArrayIsEmpty_WhenCallingLoadPopular_ThenMoviesArrayShouldntBeEmpty() {
        let repository = MockMovieRepository()
        let vm = ListScreenViewModel(movieRepository: repository)
        
        vm.loadPopular()
        
        XCTAssertFalse(vm.movies.isEmpty)
    }
    
    func testGivenMoviesArrayIssEmpty_WhenCallingloadPopularWithError_ThenMoviesArrayShoudlBeEmpty() {
        let repository = MockMovieRepository()
        let vm = ListScreenViewModel(movieRepository: repository)
        
        repository.withError = true
        
        vm.loadPopular()
        
        XCTAssertTrue(vm.movies.isEmpty)
    }
    
    func testGivenMoviesArrayIsEmpty_WhenCallingLoadGenre_ThenMoviesArrayShouldntBeEmpty() {
        let repository = MockMovieRepository()
        let vm = ListScreenViewModel(movieRepository: repository)
        
        vm.loadGenre(id: 0)
        
        XCTAssertFalse(vm.movies.isEmpty)
    }
    
    func testGivenMoviesArrayIsEmpty_WhenCallingLoadGenreWithError_ThenMoviesArrayShoudlBeEmpty() {
        let repository = MockMovieRepository()
        let vm = ListScreenViewModel(movieRepository: repository)
        
        repository.withError = true
        
        vm.loadPopular()
        
        XCTAssertTrue(vm.movies.isEmpty)
    }
}
