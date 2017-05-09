//
//  MovieContainer.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import RealmSwift

class MovieContainer {
    
    func fetchNowPlaying(completion: @escaping (Result<[Movie]>) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                
                let realm = try Realm()
                let movieEntities = realm.objects(MovieEntity.self)
                
                var movies = [Movie]()
                for entity in movieEntities {
                    movies.append(Movie(movieEntity: entity))
                }
                
                completion(.success(movies))
                
            } catch {
                completion(.failure(error))
            }
            
        }
        
    }
    
    func updateNowPlaying(with movies: [Movie]) {
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let realm = try Realm()
                
                let oldMovieEntities = realm.objects(MovieEntity.self)
                let newMovieEntities = movies.map { MovieEntity(movie: $0) }
                
                try realm.write {
                    realm.delete(oldMovieEntities)
                    realm.add(newMovieEntities)
                }
                
            } catch {
                print("Realm error:\n\(error)")
            }
            
        }
        
    }
    
    
}
