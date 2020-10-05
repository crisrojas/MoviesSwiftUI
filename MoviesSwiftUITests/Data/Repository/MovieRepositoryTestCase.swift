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
    let expectedCreditsResponse = CreditsResponse.mock
    let expectedMovie = Stubs.movie
   
    
    override func setUp() {
        
        output = MockMovieRepositoryOutput()
        
        api = MockMovieDbApi()
        api.movieResponse = expectedMovieResponse
        api.genresResponse = expectedGenresResponse
        api.creditsResponse = expectedCreditsResponse
        api.movie = expectedMovie
        
        repository = MovieRepository(api: api)
        repository.output = output
    }
    
    func testFecthtNowPlayingSuccess() {
        
        repository.fetchNowPlaying()
        if case .success = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchNowPlayingFailure() {
        
        api.withError = true
        repository.fetchNowPlaying()
        
        if case .failure = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    
    func testFetchPopularSuccess() {
        
        repository.fetchPopular()
        if case .success = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchPopularFailure() {
        
        api.withError = true
        repository.fetchPopular()
        
        if case .failure = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFecthTopRatedSuccess() {
        
        repository.fetchTopRated()
        if case .success = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    
    func testTopRatedFailure() {
        
        api.withError = true
        repository.fetchTopRated()
        
        if case .failure = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchUpcomingSuccess() {
        
        repository.fetchUpcoming()
        if case .success = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchUpcomingFailure() {
        
        api.withError = true
        repository.fetchUpcoming()
        
        if case .failure = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchGenreSuccess() {
        
        repository.fetchGenre(id: 1, page: 1)
        if case .success = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    
    func testFetchGenreFailure() {
        
        api.withError = true
        repository.fetchGenre(id: 1, page: 1)
        
        if case .failure = output.movies {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchGenresSuccess() {
        
        repository.fetchGenres()
        if case .success = output.genres {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchGenresFailure() {
        
        api.withError = true
        repository.fetchGenres()
    
        
        if case .failure = output.genres {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchMovieSuccess() {
        
        repository.fetchMovie(id: Stubs.movie.id)
        XCTAssertTrue(api.isGetMovieCalled)
        
        if case .success = output.movie {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
        
    }
    
    func testFetchMovieFailure() {
        
        api.withError = true
        repository.fetchMovie(id: Stubs.movie.id)
        
        if case .failure = output.movie {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testFetchCreditsSuccess() {
        
        repository.fetchCredits(id: "")
        
        if case .success = output.credits {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
        
    }
    
    func testFetchCreditsFaiure() {
        
        api.withError = true
        repository.fetchCredits(id: "")
        
        if case .failure = output.credits {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
        
    }
    
}
