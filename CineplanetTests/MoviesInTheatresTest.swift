//
//  MoviesInTheatresTest.swift
//  Cineplanet
//
//  Created by Jaime Laino on 4/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
@testable import Cineplanet

class MoviesInTheatresViewMock : MoviesInTheatresView {
    var showErrorCalled =  false
    var updateMoviesCalled = false
    var didStartRequestCalled = false
    var didFinishRequestCalled = false
    var errorMessage = ""
    
    func showError(message: String) {
        showErrorCalled = true
        errorMessage = message
    }
    
    func onUpdateMovies() {
        updateMoviesCalled = true
    }
    
    func didStartRequest() {
        didStartRequestCalled = true
    }
    
    func didFinishRequest() {
        didFinishRequestCalled = true
    }
}

struct MoviesInTheatresResponseMock : MovieResponseData {
    let page : Int = 1
    let results = [Movie]()
    let totalResults : Int = 0
    let totalPages : Int = 1
}

struct MovieServiceMock : MovieService {
    var testSucces = true
    let error = NSError(domain: "Test", code: 1001, userInfo: nil)
    
    func retrieveMovieList(completion: @escaping MoviesInTheatresResponseHandler) {
        if !testSucces {
            completion(NetworkResult.failure(error))
            return
        }
        
        completion(NetworkResult.success(MoviesInTheatresResponseMock()))
    }
}

class MoviesInTheatresTest: XCTestCase {
    var service : MovieServiceMock!
    
    override func setUp() {
        super.setUp()
        service = MovieServiceMock()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testShowError() {
        service.testSucces = false
        
        let mockView = MoviesInTheatresViewMock()
        let presenter = MoviesInTheatresPresenter(view: mockView, service: service)
        
        presenter.listMovies()
        XCTAssertTrue(mockView.didStartRequestCalled)
        XCTAssertTrue(mockView.didFinishRequestCalled)
        XCTAssertTrue(mockView.showErrorCalled)
        XCTAssertEqual(mockView.errorMessage, service.error.localizedDescription)
    }
    
    func testSuccesUpdate() {
        service.testSucces = true
        
        let mockView = MoviesInTheatresViewMock()
        let presenter = MoviesInTheatresPresenter(view: mockView, service: service)
        
        presenter.listMovies()
        XCTAssertTrue(mockView.didStartRequestCalled)
        XCTAssertTrue(mockView.didFinishRequestCalled)
        XCTAssertTrue(mockView.updateMoviesCalled)
    }
}
