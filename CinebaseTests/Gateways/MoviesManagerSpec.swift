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
    private var callbackCount = 0
    
    override func spec() {
        super.spec()
        
        describe("a Movies Manager") {
            
            var sut: MoviesManager!
            var mockAPIClient: MockMoviesAPIClient!
            var mockContainer: MockMoviesContainer!
            beforeEach {
                mockAPIClient = MockMoviesAPIClient()
                mockContainer = MockMoviesContainer(containerName: "MockMovies")
                sut = MoviesManager(moviesAPIClient: mockAPIClient, apiSource: .nowPlaying, moviesContainer: mockContainer)
                self.fetchingResult = nil
                self.callbackCount = 0
            }
            
            it("shouldn't fetch from the local storage or web") {
                expect(mockAPIClient.isFetchingMovies).to(beFalse())
                expect(mockContainer.isFetchingAll).to(beFalse())
                expect(self.fetchingResult).to(beNil())
            }
            
            context("when fetchNowPlaying is called") {
                beforeEach {
                    sut.fetchNowPlaying { result in
                        self.fetchingResult = result
                        self.callbackCount += 1
                    }
                }
                
                it("should call first from the local storage and not the web") {
                    expect(mockAPIClient.isFetchingMovies).to(beFalse())
                    expect(mockContainer.isFetchingAll).to(beTrue())
                }
                
                context("when the local fetching finishes with no values") {
                    beforeEach {
                        mockContainer.completeFetching(with: .success([]))
                    }
                    it("shouldn't execute the callback") {
                        expect(self.fetchingResult).to(beNil())
                        expect(self.callbackCount).to(equal(0))
                    }
                    
                    it("should fetch from the server") {
                        expect(mockAPIClient.isFetchingMovies).to(beTrue())
                    }
                    
                    context("when the remote fetching finishes with error") {
                        beforeEach {
                            mockAPIClient.completeFetching(with: .failure(FetchingError()))
                        }
                        it("shouldn execute the callback with failure") {
                            expect(self.fetchingResult?.error).toNot(beNil())
                            expect(self.callbackCount).to(equal(1))
                        }
                    }
                    
                    context("when the remote fetching finishes with values"){
                        var remoteMovie: Movie!
                        beforeEach {
                            remoteMovie = Movie(movieID: 1, title: "First movie", overview: "Great movie. Recommended.", imagePath: "/first_image.png", backdropPath: "/first_backdrop.png", releaseDate: Date())
                            mockAPIClient.completeFetching(with: .success([remoteMovie]))
                        }
                        it("should execute the callback with success") {
                            expect(self.fetchingResult?.value).toNot(beNil())
                            expect(self.callbackCount).to(equal(1))
                        }
                        it("should update the local storage") {
                            expect(mockContainer.isReplacingAll).to(beTrue())
                        }
                    }
                    
                }
                
                context("when the local fetching finishes with values") {
                    var localMovie: Movie!
                    beforeEach {
                        localMovie = Movie(movieID: 1, title: "First movie", overview: "Great movie. Recommended.", imagePath: "/first_image.png", backdropPath: "/first_backdrop.png", releaseDate: Date())
                        mockContainer.completeFetching(with: .success([localMovie]))
                    }
                    
                    it("should execute the callback") {
                        expect(self.fetchingResult?.value).toNot(beNil())
                        expect(self.callbackCount).to(equal(1))
                    }
                    
                    it("should fetch from the server") {
                        expect(mockAPIClient.isFetchingMovies).to(beTrue())
                    }
                    
                    context("when the remote fetching finishes with error") {
                        beforeEach {
                            mockAPIClient.completeFetching(with: .failure(FetchingError()))
                        }
                        it("shouldn't execute the callback again") {
                            expect(self.callbackCount).to(equal(1))
                        }
                        // TODO: test retry (not implemented yet)
                        //  it("should retry")
                    }
                    
                    context("when the remote fetching finishes with the same values"){
                        var remoteMovie: Movie!
                        beforeEach {
                            remoteMovie = Movie(movieID: 1, title: "First movie", overview: "Great movie. Recommended.", imagePath: "/first_image.png", backdropPath: "/first_backdrop.png", releaseDate: localMovie.releaseDate)
                            mockAPIClient.completeFetching(with: .success([remoteMovie]))
                        }
                        it("shouldn't execute the callback") {
                            expect(self.callbackCount).to(equal(1))
                        }
                        it("shouldn't update the local storage") {
                            expect(mockContainer.isReplacingAll).to(beFalse())
                        }
                    }
                    
                    context("when the remote fetching finishes with new values"){
                        var remoteMovie: Movie!
                        beforeEach {
                            remoteMovie = Movie(movieID: 2, title: "New movie", overview: "New Great movie. Recommended.", imagePath: "/first_image.png", backdropPath: "/new_backdrop.png", releaseDate: Date())
                            mockAPIClient.completeFetching(with: .success([remoteMovie]))
                        }
                        it("should execute the callback") {
                            expect(self.callbackCount).to(equal(2))
                        }
                        it("should update the local storage") {
                            expect(mockContainer.isReplacingAll).to(beTrue())
                        }
                    }
                }
                
            }
        }
        
    }
    
}

// MARK: Mocks
extension MoviesManagerSpec {
    class MockMoviesAPIClient: MoviesAPIClient {
        
        private(set) var isFetchingMovies = false
        private(set) var fetchMoviesCompletion: ((Result<[Movie]>) -> Void)?
        override func fetchMovies(from source: Source, completion: @escaping (Result<[Movie]>) -> Void) -> WebAPIRequestProtocol {
            isFetchingMovies = true
            fetchMoviesCompletion = completion
            return MockWebAPIRequest()
        }
        
        func completeFetching(with result: Result<[Movie]>) {
            fetchMoviesCompletion?(result)
            fetchMoviesCompletion = nil
        }
    }
    
    class MockMoviesContainer: MoviesContainer {
        
        private(set) var isFetchingAll = false
        private(set) var fetchAllCompletion: ((Result<[Movie]>) -> Void)?
        override func fetchAll(completion: @escaping (Result<[Movie]>) -> Void) {
            isFetchingAll = true
            fetchAllCompletion = completion
        }
        
        func completeFetching(with result: Result<[Movie]>) {
            fetchAllCompletion?(result)
            fetchAllCompletion = nil
        }
        
        private(set) var isReplacingAll = false
        override func replaceAll(with movies: [Movie], completion: @escaping (Result<Void>) -> Void) {
            isReplacingAll = true
        }
    }
    
    class FetchingError: Error { }
}
