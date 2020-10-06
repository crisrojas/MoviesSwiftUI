//
//  MoyaMovieDbTests.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
import Moya
@testable import MoviesSwiftUI

class MoyaMovieDbTests: XCTestCase {
    
    var expectationTest: XCTestExpectation!
    
    func testDataIsLoaded() {
        let data = Bundle.loadStub(filename: "movie_list")
        XCTAssert(data != nil)
    }
    
    func testDataDecoding() {
        let data: MovieResponse? = try? Bundle.loadData(filename: "movie_list")
        XCTAssert(data != nil)
    }
    
    func testDataDecodingIsCorrect() {
        let data: MovieResponse = try! Bundle.loadData(filename: "movie_list")!
        XCTAssertEqual(data.results[0].title, "Bloodshot")
        XCTAssertEqual(data.results.count, 20)
    }
    
    func testMapReponseSuccess() {
        let data = Bundle.loadStub(filename: "movie_list")
        let response = Moya.Response(statusCode: 200, data: data!)
        let result: Result<Moya.Response, MoyaError> = Result.success(response)
        let movieResponse: Result<MovieResponse, Error> = result.mapResponse()
        
        if case .success = movieResponse {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testMapResponseSerializationError() {
        let response = Moya.Response(statusCode: 200, data: Data())
        let result: Result<Moya.Response, MoyaError> = Result.success(response)
        let movieResponse: Result<MovieResponse, Error> = result.mapResponse()
        
        if case .failure(.serializationError) = movieResponse {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testMapResponseNetworkError() {
        let moyaResponse = Moya.Response(statusCode: 500, data: Data())
        let moyaError = MoyaError.statusCode(moyaResponse)
        let result: Result<Moya.Response, MoyaError> = Result.failure(moyaError)
        let movieResponse: Result<MovieResponse, Error> = result.mapResponse()
        
        if case .failure(.networkError) = movieResponse {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
}
