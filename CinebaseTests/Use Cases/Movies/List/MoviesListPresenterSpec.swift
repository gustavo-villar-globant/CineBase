//
//  NowPlayingPresenterSpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/21/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import Cinebase

class MoviesListPresenterSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("A Now Playing Presenter") {
            
            var sut: MoviesListPresenter!
            var mockView: MockMoviesListView!
            var mockRouter: MockRouter!
            var mockManager: MockMoviesManager!
            
            beforeEach {
                mockView = MockMoviesListView()
                mockRouter = MockRouter()
                mockManager = MockMoviesManager(configuration: .nowPlaying)
                sut = MoviesListPresenter(view: mockView, moviesManager: mockManager)
                sut.showDetail = { _ in
                    mockRouter.isShowingDetail = true
                }
            }
            
            context("when the view is loaded") {
                
                beforeEach {
                    sut.onViewLoad()
                }
                it("should fetch the movies") {
                    expect(mockManager.isFetchingNowPlaying).to(beTrue())
                    expect(mockView.isLoading).to(beTrue())
                }
                
                context("when the request fails") {
                    var networkError: Error!
                    beforeEach {
                        networkError = NSError()
                        mockManager.completeFetching(with: .failure(networkError))
                    }
                    it("should display the error") {
                        expect(mockView.displayedError).toEventually(be(networkError))
                    }
                }
                
                context("when the request completes successfully") {
                    var movie: Movie!
                    beforeEach {
                        movie = Movie(movieID: 1, title: "First movie", overview: "Great movie. Recommended.", imagePath: "/first_image.png", backdropPath: "/first_backdrop.png", releaseDate: nil)
                        mockManager.completeFetching(with: .success([movie]))
                    }
                    it("should display the movie cells") {
                        let movieCell = MovieCellModel(title: "First movie", imagePath: "/first_image.png", releaseDate: "Coming soon")
                        expect(mockView.displayedMovies).toEventually(equal([movieCell]))
                    }
                    
                    context("when the manager retrieves updated movies") {
                        var movie: Movie!
                        beforeEach {
                            movie = Movie(movieID: 2, title: "New movie", overview: "New movie. Recommended.", imagePath: "/new_image.png", backdropPath: "/new_backdrop.png", releaseDate: Date(unixTimestamp: 1510000000000))
                            mockManager.completeFetching(with: .success([movie]))
                        }
                        it("should update the movie cells") {
                            let movieCell = MovieCellModel(title: "New movie", imagePath: "/new_image.png", releaseDate: "11/6/17")
                            expect(mockView.updatedMovies).toEventually(equal([movieCell]))
                        }
                    }
                    
                    context("when an item is selected") {
                        beforeEach {
                            waitUntil { done in
                                // wait for the view to be updated with the new cells
                                Thread.sleep(forTimeInterval: 0.1)
                                done()
                            }
                            sut.onItemSelected(at: 0)
                        }
                        it("should show movie details") {
                            expect(mockRouter.isShowingDetail).to(beTrue())
                        }
                    }
                }
                
            }
            
        }
        
    }
    
}

// MARK: - Mocks
extension MoviesListPresenterSpec {
    
    class MockMoviesListView: MoviesListView {
        
        var movieCellModels: [MovieCellModel] = []
        
        private(set) var isLoading = false
        
        func startLoading() {
            isLoading = true
        }
        func stopLoading() {
            isLoading = false
        }
        
        private(set) var displayedMovies = [MovieCellModel]()
        func displayMovies(_ movieCellModels: [MovieCellModel]) {
            self.movieCellModels = movieCellModels
            displayedMovies = movieCellModels
        }
        
        private(set) var updatedMovies = [MovieCellModel]()
        func updateMovies(_ movieCellModels: [MovieCellModel]) {
            self.movieCellModels = movieCellModels
            updatedMovies = movieCellModels
        }
        
        private(set) var displayedError: Error?
        func display(_ error: Error) {
            displayedError = error
        }
    }
    
    class MockRouter {
        var isShowingDetail = false
    }
    
    class MockMoviesManager: MoviesManager {
        
        private(set) var isFetchingNowPlaying = false
        private(set) var fetchNowPlayingCompletion: ((Result<[Movie]>) -> Void)?
        override func fetchNowPlaying(completion: @escaping (Result<[Movie]>) -> Void) {
            isFetchingNowPlaying = true
            fetchNowPlayingCompletion = completion
        }
        
        func completeFetching(with result: Result<[Movie]>) {
            fetchNowPlayingCompletion?(result)
        }
    }
}
