//
//  CategoriesViewModelTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class CategoriesViewModelTestCase: XCTestCase {

    func testGivenModelIsNil_WhenCallingLoadGenres_ThenModelShouldntBeNil() {
            let repository = MockMovieRepository()
            let vm = CategoriesViewModel(repository: repository)

            vm.loadGenres()

        XCTAssertFalse(vm.model == nil)
    }
    
    func testGivenModleIsNil_WhenCallingLoadGenresWithError_ThenModelShouldStillNil() {
        let repository = MockMovieRepository()
        let vm = CategoriesViewModel(repository: repository)
        
        vm.loadGenres()
        repository.withError = true
    }

}
