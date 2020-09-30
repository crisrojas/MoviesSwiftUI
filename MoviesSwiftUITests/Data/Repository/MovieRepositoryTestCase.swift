//
//  MovieRepositoryTestCase.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import XCTest
@testable import MoviesSwiftUI

class MovieRepositoryTestCase: XCTestCase {

    var output: MockMovieRepositoryOutput!
    var api: MockMovieDbApi!
    var repository: MovieRepository!
    
    /// Stubbs
    let expectedMovieResponse = MovieResponse(results: Stubs.movies)
    let expectedGenresResponse = GenresResponse(genres: Stubs.genres)
    
    override func setUp() {
        
        output = MockMovieRepositoryOutput()
        
        api = MockMovieDbApi()
        api.movieResponse = expectedMovieResponse
        api.genresResponse = expectedGenresResponse
        
        repository = MovieRepository(api: api)
        repository.output = output
    }
    
    func testFecthtNowPlayingSuccess() {
        
        repository.fetchNowPlaying()
        if case .success = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchNowPlayingFailure() {
        
        api.withError = true
        repository.fetchNowPlaying()
        
        if case .failure = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    
    func testFetchPopularSuccess() {
        
        repository.fetchPopular()
        if case .success = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchPopularFailure() {
        
        api.withError = true
        repository.fetchPopular()
        
        if case .failure = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFecthTopRatedSuccess() {
        
        repository.fetchTopRated()
        if case .success = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    
    func testTopRatedFailure() {
        
        api.withError = true
        repository.fetchTopRated()
        
        if case .failure = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchUpcomingSuccess() {
        
        repository.fetchUpcoming()
        if case .success = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchUpcomingFailure() {
        
        api.withError = true
        repository.fetchUpcoming()
        
        if case .failure = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchGenreSuccess() {
        
        repository.fetchGenre(id: 1, page: 1)
        if case .success = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    
    func testFetchGenreFailure() {
        
        api.withError = true
        repository.fetchGenre(id: 1, page: 1)
        
        if case .failure = output.moviesModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchGenresSuccess() {
        
        repository.fetchGenres()
        if case .success = output.genresModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchGenresFailure() {
        
        api.withError = true
        repository.fetchGenres()
        
        if case .failure = output.genresModel {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    
}
