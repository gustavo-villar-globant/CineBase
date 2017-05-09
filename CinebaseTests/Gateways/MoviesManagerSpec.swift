//
//  MoviesManagerSpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Quick
import Nimble
@testable import Cinebase

class MoviesManagerSpec: QuickSpec {
    
    private var fetchingResult: Result<[Movie]>?
    
    override func spec() {
        super.spec()
        
        describe("a Movies Manager") {
            
            var sut: MoviesManager!
            var mockAPIClient: MockMoviesAPIClient!
            var mockContainer: MockMoviesContainer!
            beforeEach {
                mockAPIClient = MockMoviesAPIClient()
                mockContainer = MockMoviesContainer()
                sut = MoviesManager(moviesAPIClient: mockAPIClient, moviesContainer: mockContainer)
            }
            
            it("shouldn't fetch from the local storage or web") {
                expect(mockAPIClient.isFetchingNowPlaying).to(beFalse())
                expect(mockContainer.isFetchingNowPlaying).to(beFalse())
            }
            
            context("when fetchNowPlaying is called") {
                beforeEach {
                    sut.fetchNowPlaying { result in
                        self.fetchingResult = result
                    }
                }
                
                it("should call first from the local storage and not the web") {
                    expect(mockAPIClient.isFetchingNowPlaying).to(beFalse())
                    expect(mockContainer.isFetchingNowPlaying).to(beTrue())
                }
                
                context("when the local fetching finishes with no values") {
                    beforeEach {
                        mockContainer.completeFetching(with: .success([]))
                    }
                }
                
                context("when the local fetching finishes with values") {
                    var localMovie: Movie!
                    beforeEach {
                        localMovie = Movie(movieID: 1, title: "First movie", overview: "Great movie. Recommended.", imagePath: "/first_image.png", backdropPath: "/first_backdrop.png")
                        mockContainer.completeFetching(with: .success([localMovie]))
                    }
                    
                    it("should fetch from the server") {
                        expect(mockAPIClient.isFetchingNowPlaying).to(beTrue())
                    }
                }
                
            }
        }
        
    }
    
}

// MARK: Mocks
extension MoviesManagerSpec {
    class MockMoviesAPIClient: MoviesAPIClient {
        
        private(set) var isFetchingNowPlaying = false
        private(set) var fetchNowPlayingCompletion: ((Result<[Movie]>) -> Void)?
        override func fetchNowPlaying(completion: @escaping (Result<[Movie]>) -> Void) -> WebAPIRequestProtocol {
            isFetchingNowPlaying = true
            fetchNowPlayingCompletion = completion
            return MockWebAPIRequest()
        }
        
        func completeFetching(with result: Result<[Movie]>) {
            fetchNowPlayingCompletion?(result)
            fetchNowPlayingCompletion = nil
        }
    }
    
    class MockMoviesContainer: MoviesContainer {
        
        private(set) var isFetchingNowPlaying = false
        private(set) var fetchNowPlayingCompletion: ((Result<[Movie]>) -> Void)?
        override func fetchNowPlaying(completion: @escaping (Result<[Movie]>) -> Void) {
            isFetchingNowPlaying = true
            fetchNowPlayingCompletion = completion
        }
        
        func completeFetching(with result: Result<[Movie]>) {
            fetchNowPlayingCompletion?(result)
            fetchNowPlayingCompletion = nil
        }
    }
}
