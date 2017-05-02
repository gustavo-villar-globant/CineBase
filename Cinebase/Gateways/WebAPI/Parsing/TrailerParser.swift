//
//  TrailerParser.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/2/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class TrailerParser: ModelParser {
    typealias Model = Trailer
    
    /// Base path for URL attributes
    var baseURL: String
    
    var movieID: Int
    
    init(baseURL: String, movieID: Int) {
        self.baseURL = baseURL
        self.movieID = movieID
    }
    
    func parseArray(fromJSONArray jsonArray: [[String: Any]]) -> Result<[Model]> {
        
        var modelArray = [Model]()
        
        for json in jsonArray {
            
            if (json["type"] as? String) == "Trailer" {
                let parseResult = parse(fromJSON: json)
                switch parseResult {
                case .failure(let error):
                    return .failure(error)
                case .success(let model):
                    modelArray.append(model)
                }
            }
            
        }
        
        return .success(modelArray)
        
    }
    
    func parse(fromJSON json: [String : Any]) -> Result<Model> {
        
        guard let key = json["key"] as? String,
            let size = json["size"] as? Int else {
                let parsingError = ParsingError<Model>(json: json)
                return .failure(parsingError)
        }
        
        let trailer = Trailer(key: key, movieID: movieID, size: size)
        
        return .success(trailer)
        
    }
}
