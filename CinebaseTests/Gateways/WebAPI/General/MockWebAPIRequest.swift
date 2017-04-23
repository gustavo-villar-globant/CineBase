//
//  MockWebAPIRequest.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/21/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
@testable import Cinebase

class MockWebAPIRequest: WebAPIRequestProtocol {
    
    enum State {
        case running
        case suspended
        case cancelled
        case completed
    }
    
    private(set) var state = State.running
    
    func resume() {
        state = .running
    }
    
    /// Suspends the request.
    func suspend() {
        state = .suspended
    }
    
    /// Cancels the request.
    func cancel() {
        state = .cancelled
    }
    
    /// The progress of fetching the response data from the server for the request.
    var progress = Progress(totalUnitCount: 100)
    
    /// Sets a closure to be called periodically during the lifecycle of the `Request` as data is read from the server.
    @discardableResult
    func downloadProgress(queue: DispatchQueue, closure: @escaping (Progress) -> Void) -> Self {
        return self
    }
    
}
