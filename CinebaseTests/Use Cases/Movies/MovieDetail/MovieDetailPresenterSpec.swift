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
            var mockRouter: MockMovieDetailRouter!
            var mockAuthenticationManager: MockAuthenticationManager!
            var movie: Movie!
            beforeEach {
                mockView = MockMovieDetailView()
                mockRouter = MockMovieDetailRouter()
                movie = Movie(movieID: 1, title: "Movie with detail", overview: "Amazing movie review detail", imagePath: "/awesome.png")
                mockAuthenticationManager = MockAuthenticationManager()
                sut = MovieDetailPresenter(view: mockView, router: mockRouter, movie: movie, authenticationManager: mockAuthenticationManager)
            }
            
            context("when the view is loaded") {
                beforeEach {
                    sut.onViewLoad()
                }
                it("should display the movie details") {
                    let movieViewModel = MovieViewModel(title: "Movie with detail", imagePath: "/awesome.png", overview: "Amazing movie review detail")
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
    
    class MockMovieDetailRouter: MovieDetailRouterProtocol {
        private(set) var isPresentingBuyingOptions = false
        func presentBuyingOptions(for user: User, and movie: Movie) {
            isPresentingBuyingOptions = true
        }
    }

}