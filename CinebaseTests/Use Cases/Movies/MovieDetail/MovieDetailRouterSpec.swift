//
//  MovieDetailRouterSpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Quick
import Nimble
@testable import Cinebase

class MovieDetailRouterSpec: QuickSpec {
    

    override func spec() {
        super.spec()
        
        describe("a movie detail router") {
            var sut: MovieDetailRouter!
            var mockViewController: MockMovieDetailViewController!
            beforeEach {
                mockViewController = MockMovieDetailViewController()
                sut = MovieDetailRouter(mockViewController)
            }
            
            context("when present buying options is called") {
                beforeEach {
                    let user = User(userID: "", name: "John")
                    let movie = Movie(movieID: 1, title: "Avengers", overview: "", imagePath: "", backdropPath: "")
                    sut.presentBuyingOptions(for: user, and: movie)
                }
                it("should present buying options") {
                    expect(mockViewController.isPresentingViewController).to(beTrue())
                }
            }
            
        }
    }
    
}

// MARK: - Mocks
extension MovieDetailRouterSpec {
    
    class MockMovieDetailViewController: MovieDetailViewController {
        private(set) var isPresentingViewController = false
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            isPresentingViewController = true
        }
    }
    
}
