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

class NowPlayingPresenterSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("A Now Playing Presenter") {
            
            var sut: NowPlayingPresenter!
            var mockView: MockNowPlayingView!
            var mockRouter: MockNowPlayingRouter!
            var mockAPIClient: MockMoviesAPIClient!
            
            beforeEach {
                mockView = MockNowPlayingView()
                mockRouter = MockNowPlayingRouter()
                mockAPIClient = MockMoviesAPIClient()
                sut = NowPlayingPresenter(view: mockView, router: mockRouter, moviesAPIClient: mockAPIClient)
            }
            
            context("When the view is loaded") {
                
                beforeEach {
                    sut.onViewLoad()
                }
                it("should fetch the movies") {
                    expect(mockAPIClient.isFetchingNowPlaying).to(beTrue())
                    expect(mockView.isLoading).to(beTrue())
                }
                
            }
            
        }
        
    }
    
}

// MARK: - Mocks
extension NowPlayingPresenterSpec {
    
    class MockNowPlayingView: NowPlayingView {
        private(set) var isLoading = false
        func startLoading() {
            isLoading = true
        }
        func stopLoading() {
            isLoading = false
        }
        
        private(set) var displayedMovies = [MovieCellModel]()
        func displayMovies(_ movieCellModels: [MovieCellModel]) {
            displayedMovies = movieCellModels
        }
        
        private(set) var displayedError: Error?
        func display(_ error: Error) {
            displayedError = error
        }
    }
    
    class MockNowPlayingRouter: NowPlayingRouterProtocol {
        private(set) var isShowingDetail = false
        func showDetail(of movie: Movie) {
            isShowingDetail = true
        }
    }
    
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
}
