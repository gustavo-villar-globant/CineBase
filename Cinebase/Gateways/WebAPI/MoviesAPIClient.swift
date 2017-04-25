//
//  MoviesAPIClient.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class MoviesAPIClient {
    
    private let webAPIClient = WebAPIClient()
    
    func fetchNowPlaying(completion: @escaping (Result<[Movie]>) -> Void) -> WebAPIRequestProtocol {
        
        return webAPIClient.request(.get, path: "/movie/now_playing", queryParameters: ["language": Locale.current.languageCode!]) { (result) in
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                
                guard let json = response as? [String: Any],
                    let movieJSONArray = json["results"] as? [[String: Any]] else {
                        let error = ParsingError<[Movie]>(json: response)
                        completion(.failure(error))
                        return
                }
                
                let movieParser = MovieParser()
                let parseResult = movieParser.parseArray(fromJSONArray: movieJSONArray)
                completion(parseResult)
                
            }
            
        }
        
    }
    
}
