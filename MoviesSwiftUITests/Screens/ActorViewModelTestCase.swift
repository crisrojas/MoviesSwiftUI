//
//  ActorViewModelTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 30/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI


class ActorViewModelTestCase: XCTestCase {
    
    var repository: MockMovieRepository!
    var vm: ActorViewModel!
    
    override func setUp() {
        super.setUp()
        repository = MockMovieRepository()
        vm = ActorViewModel(creditId: "", repository: repository)
    }
    
    func testGivenModelIsNil_WhenCallingLoadCredits_ThenModelShouldntBeNil() {
        vm.loadCredits()
        
        XCTAssertFalse(vm.model == nil)
    }
    
    func testGivenModelIsNil_WhenCallingLoadCreditsWithError_ThenModelShouldBeNil() {
        repository.withError = true
        
        vm.loadCredits()
        XCTAssertTrue(vm.model == nil)
    }

}
