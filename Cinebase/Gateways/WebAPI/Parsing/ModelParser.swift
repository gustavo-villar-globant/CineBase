//
//  ModelParser.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

/**
 Protocol for parsing the Web API response into a Model.
*/
protocol ModelParser {
    associatedtype Model
    func parse(fromJSON json: [String: Any]) -> Result<Model>
    /**
     Optional method to parse multiple models from a jsonArray.
     By default, uses `parse(fromJSON:)` on each element of the array.
     */
    func parseArray(fromJSONArray jsonArray: [[String: Any]]) -> Result<[Model]>
}

// MARK: - Default parse array implementation
extension ModelParser {
    
    /// Default implementation of `parseArray(fromJSONArray:)` based on `parse(fromJSON:)`
    func parseArray(fromJSONArray jsonArray: [[String: Any]]) -> Result<[Model]> {
        
        var modelArray = [Model]()
        
        for json in jsonArray {
            
            let parseResult = parse(fromJSON: json)
            switch parseResult {
            case .failure(let error):
                return .failure(error)
            case .success(let model):
                modelArray.append(model)
            }
            
        }
        
        return .success(modelArray)
        
    }
}
