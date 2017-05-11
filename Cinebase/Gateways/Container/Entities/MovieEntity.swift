//
//  MovieEntity.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/5/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    
    dynamic var movieID = -1
    dynamic var title = ""
    dynamic var overview = ""
    dynamic var imagePath = ""
    dynamic var backdropPath = ""
    
    override static func primaryKey() -> String? {
        return "movieID"
    }
    
    static func ==(lhs: MovieEntity, rhs: MovieEntity) -> Bool {
        return  lhs.movieID == rhs.movieID &&
            lhs.title == rhs.title &&
            lhs.overview == rhs.overview &&
            lhs.imagePath == rhs.imagePath &&
            lhs.backdropPath == rhs.backdropPath
        
    }
    
    convenience init(movie: Movie) {
        self.init()
        self.movieID = movie.movieID
        update(with: movie)
    }
    
    func update(with movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview
        self.imagePath = movie.imagePath
        self.backdropPath = movie.backdropPath
    }
    
}

// MARK: Movie from MovieEntity
extension Movie {
    init(movieEntity: MovieEntity) {
        self = Movie(
            movieID: movieEntity.movieID,
            title: movieEntity.title,
            overview: movieEntity.overview,
            imagePath: movieEntity.imagePath,
            backdropPath: movieEntity.backdropPath
        )
    }
}
