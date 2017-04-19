//
//  Result.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

enum Result<Value> {
    
    case success(Value)
    case failure(Error)
    
    var value: Value? {
        guard case .success(let value) = self else { return nil }
        return value
    }
    var error: Error? {
        guard case .failure(let error) = self else { return nil }
        return error
    }
}
