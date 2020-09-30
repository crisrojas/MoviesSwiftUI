//
//  MoviesDetailViewModelTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class MoviesDetailViewModelTestCase: XCTestCase {


    func testGivenModelIsAnEmptyMock_WhenCallingLoadMovies_ModelShouldBeFilled() {
            let repository = MockMovieRepository()
            let vm = MovieDetailViewModel(movieId: 1, movieRepository: repository)
            
            vm.loadMovie()
            
        XCTAssertEqual(vm.model.title, "Bloodshot")
    }
}
