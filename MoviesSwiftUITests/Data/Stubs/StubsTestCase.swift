//
//  StubTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class StubTestCase: XCTestCase {
    
    func testUnitTestBundleIdentifierIsRetrieved() {
        let bundle = Bundle(identifier: "fr.v-labs.MoviesSwiftUITests")
        XCTAssertTrue(bundle != nil)
    }
   
    // Checks if files are found in UnitTest Bundle
    func testGenresStubFileIsFoundInUnitTestBundle() {
        let data = Bundle.loadStub(filename: "genres")
        XCTAssertTrue(data != nil)
    }
    
    // Checkfs if files are correctley decoded to the model
    func testGenresStubFileIsDecoded() {
        let response: GenresResponse? = try? Bundle.loadData(filename: "genres")
        XCTAssertTrue(response != nil)
    }
    
    func testMovieListStubFileIsDecoded() {
        let response: MovieResponse? = try? Bundle.loadData(filename: "movie_list")
        XCTAssertTrue(response != nil)
    }
    
    
    
    
}
