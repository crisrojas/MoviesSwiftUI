//
//  MoviesMoreViewModel.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class MoviesMoreViewModelTest: XCTestCase {

    func testGivenModelIsEmpty_WhenCallingLoadUpcomping_ThenModelShouldntBeEmpty() {
        let repository = MockMovieRepository()
        let vm = MoviesMoreViewModel(movieRepository: repository)
        
        vm.loadUpcoming()
        
        XCTAssertFalse(vm.model.isEmpty)
    }
    
    func testGivenModelIsEmpty_WhenCallingLoadTopRated_ThenModelShoudlntBeEmpty() {
        let repository = MockMovieRepository()
        let vm = MoviesMoreViewModel(movieRepository: repository)
        
        vm.loadTopRated()
        
        XCTAssertFalse(vm.model.isEmpty)
    }

}
