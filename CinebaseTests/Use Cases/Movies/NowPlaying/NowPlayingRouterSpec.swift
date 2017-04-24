//
//  NowPlayingRouterSpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Quick
import Nimble
@testable import Cinebase

class NowPlayingRouterSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("a Now Playing Router") {
            
            var sut: NowPlayingRouter!
            var mockViewController: MockViewController!
            beforeEach {
                mockViewController = MockViewController()
                sut = NowPlayingRouter(mockViewController)
            }
            
            context("when show detail of movie is called") {
                var movie: Movie!
                beforeEach {
                    movie = Movie(movieID: 1, title: "Some movie", overview: "Great movie. Recommended.", imagePath: "/image.png")
                    sut.showDetail(of: movie)
                }
                
                it("should show the detail scene") {
                    expect(mockViewController.shownViewController).notTo(beNil())
                }
            }
            
        }
        
    }

}

// MARK: - Mocks
extension NowPlayingRouterSpec {
    
    class MockViewController: NowPlayingViewController {
        
        private(set) var shownViewController: UIViewController?
        override func show(_ vc: UIViewController, sender: Any?) {
            shownViewController = vc
        }
        
    }
    
}
