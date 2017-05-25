//
//  MovieParser.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class MovieParser: ModelParser {
    typealias Model = Movie
    
    /// Base path for URL attributes
    var baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func parse(fromJSON json: [String : Any]) -> Result<Movie> {
 
        let dateParser = DateParser()
        
        guard let movieID = json["id"] as? Int,
            let title = json["title"] as? String,
            let imagePath = json["poster_path"] as? String,
            let backdropPath = json["backdrop_path"] as? String,
            let overview = json["overview"] as? String,
            let releaseDateString = json["release_date"] as? String,
            let releaseDate = dateParser.parse(from: releaseDateString) else {
                let parsingError = ParsingError<Movie>(json: json)
                return .failure(parsingError)
        }
        
        let imageURL = baseURL + imagePath
        let backdropURL = baseURL + backdropPath
        
        let movie = Movie(movieID: movieID, title: title, overview: overview, imagePath: imageURL, backdropPath: backdropURL, releaseDate: releaseDate)
        return .success(movie)
        
    }
}
