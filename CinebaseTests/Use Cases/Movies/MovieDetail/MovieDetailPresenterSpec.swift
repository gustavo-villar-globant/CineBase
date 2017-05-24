//
//  MovieDetailPresenterSpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Cinebase

class MovieDetailPresenterSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("a Movie Detail Presenter") {
            
            var sut: MovieDetailPresenter!
            var mockView: MockMovieDetailView!
            var mockRouter: MockRouter!
            var mockAPIClient: MockTrailersAPIClient!
            var mockAuthenticationManager: MockAuthenticationManager!
            var movie: Movie!
            beforeEach {
                mockView = MockMovieDetailView()
                mockRouter = MockRouter()
                mockAPIClient = MockTrailersAPIClient()
                movie = Movie(movieID: 1, title: "Movie with detail", overview: "Amazing movie review detail", imagePath: "/awesome.png", backdropPath: "/backdrop.png", releaseDate: Date())
                mockAuthenticationManager = MockAuthenticationManager()
                sut = MovieDetailPresenter(view: mockView, movie: movie, authenticationManager: mockAuthenticationManager, moviesAPIClient:mockAPIClient)
                sut.presentBuyingOptions = { _ in
                    mockRouter.isPresentingBuyingOptions = true
                }
                sut.playYoutubeVideoWithKey = { _ in
                    mockRouter.isShowingTrailer = true
                }
            }
            
            context("when the view is loaded") {
                beforeEach {
                    sut.onViewLoad()
                }
                it("should display the movie details") {
                    let movieViewModel = MovieViewModel(title: "Movie with detail", backdropPath: "/backdrop.png", overview: "Amazing movie review detail")
                    expect(mockView.displayedMovieViewModel).to(equal(movieViewModel))
                }
                
                context("when buy tickets is touched") {
                    beforeEach {
                        sut.buyTickets()
                    }
                    it("should request login with Google") {
                        expect(mockAuthenticationManager.isRequestingLoginWithGoogle).to(beTrue())
                    }
                    
                    context("when the user logs in") {
                        beforeEach {
                            let user = User(userID: "", name: "")
                            sut.authenticationManager(mockAuthenticationManager, didLoginWith: user)
                        }
                        it("should present the buying options") {
                            expect(mockRouter.isPresentingBuyingOptions).to(beTrue())
                        }
                    }
                }
                
                context("when play trailer button is pressed") {
                    beforeEach {
                        sut.onPlayTrailerButtonPressed()
                    }
                    it("should fetch trailer info") {
                        expect(mockAPIClient.isFetchingTrailersOfMovie).to(beTrue())
                    }
                    context("when the request completes succesfully") {
                        var trailer: Trailer!
                        beforeEach {
                            trailer = Trailer(videoPath: "/key", key: "key", movieID: 1, size: 720)
                            mockAPIClient.completeFetching(with: .success([trailer]))
                        }
                        it("should show trailer") {
                            expect(mockRouter.isShowingTrailer).to(beTrue())
                        }
                    }
                }
                
            }
        }
    }
    
}

// MARK: - Mocks
extension MovieDetailPresenterSpec {
    
    class MockMovieDetailView: MovieDetailView {
        private(set) var displayedMovieViewModel: MovieViewModel?
        func display(_ movieViewModel: MovieViewModel) {
            displayedMovieViewModel = movieViewModel
        }
        private(set) var isPresentingLoginViewController = false
        func presentLogin(_ loginViewController: UIViewController) {
            isPresentingLoginViewController = true
        }
    }
    
    class MockRouter {
        var isPresentingBuyingOptions = false
        var isShowingTrailer = false
    }
    
    class MockTrailersAPIClient: MoviesAPIClient {
        
        private(set) var isFetchingTrailersOfMovie = false
        private(set) var fetchTrailersOfMovieWithIDCompletion: ((Result<[Trailer]>) -> Void)?
        
        override func fetchTrailers(of movie: Movie, completion: @escaping (Result<[Trailer]>) -> Void) -> WebAPIRequestProtocol {
            isFetchingTrailersOfMovie = true
            fetchTrailersOfMovieWithIDCompletion = completion
            return MockWebAPIRequest()
        }
        
        func completeFetching(with result: Result<[Trailer]>){
            fetchTrailersOfMovieWithIDCompletion?(result)
            fetchTrailersOfMovieWithIDCompletion = nil
        }
        
    }

}
