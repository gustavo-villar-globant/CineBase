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
    
    enum Source: String {
        case nowPlaying = "now_playing"
        case upcoming = "upcoming"
    }
    
    func fetchMovies(from source: Source, completion: @escaping (Result<[Movie]>) -> Void) -> WebAPIRequestProtocol {
        
        return webAPIClient.request(.get, path: "/movie/\(source.rawValue)", queryParameters: ["language": Locale.current.languageCode!]) { (result) in
            
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
                
                let movieParser = MovieParser(baseURL: WebAPIClient.imageBaseURL)
                let parseResult = movieParser.parseArray(fromJSONArray: movieJSONArray)
                completion(parseResult)
                
            }
            
        }
        
    }
    
    func fetchTrailers(of movie: Movie, completion: @escaping (Result<[Trailer]>) -> Void) -> WebAPIRequestProtocol {
        
        return webAPIClient.request(.get, path: "/movie/\(movie.movieID)/videos") { result in
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                
                guard let json = response as? [String: Any],
                    let trailerJSONArray = json["results"] as? [[String: Any]] else {
                        let error = ParsingError<[Trailer]>(json: response)
                        completion(.failure(error))
                        return
                }
                
                let trailerParser = TrailerParser(baseURL: WebAPIClient.videoBaseURL, movieID: movie.movieID)
                let parseResult = trailerParser.parseArray(fromJSONArray: trailerJSONArray, withFilter: "Trailer")
                completion(parseResult)
                
            }
            
        }
    }
    
}
