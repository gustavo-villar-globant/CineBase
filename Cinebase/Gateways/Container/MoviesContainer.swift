//
//  MovieContainer.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import RealmSwift

class MoviesContainer: LocalContainer {
    
    typealias Model = Movie
    typealias ModelID = Int
    
    /**
     Name for the realm file.
     Used to implement different containers for
     now playing and comming soon movies
    */
    private let containerName: String
    
    init(containerName: String) {
        self.containerName = containerName
    }
    
    private func makeRealm() throws -> Realm {
        let realmConfigurator = RealmConfigurator()
        return try realmConfigurator.makeRealm(on: .cache, named: containerName)
    }
    
    func find(withID id: Int, completion: @escaping (Result<Model>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                
                let realm = try self.makeRealm()
                guard let movieEntity = realm.object(ofType: MovieEntity.self, forPrimaryKey: id) else {
                    completion(.failure(NotFoundInContainerError()))
                    return
                }
                let movie = Movie(movieEntity: movieEntity)
                completion(.success(movie))
                
            } catch {
                print("Realm error:\n\(error)")
                completion(.failure(error))
            }
            
        }
    }
    
    func add(_ movie: Movie, completion: @escaping (Result<Void>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let realm = try self.makeRealm()
                let movieEntity = MovieEntity(movie: movie)
                
                try realm.write {
                    realm.add(movieEntity)
                }
                
                completion(.success())
                
            } catch {
                print("Realm error:\n\(error)")
                completion(.failure(error))
            }
            
        }
        
    }
    
    func update(_ movie: Movie, completion: @escaping (Result<Void>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let realm = try self.makeRealm()
                guard let movieEntity = realm.object(ofType: MovieEntity.self, forPrimaryKey: movie.movieID) else {
                    completion(.failure(NotFoundInContainerError()))
                    return
                }
                
                try realm.write {
                    movieEntity.update(with: movie)
                }
                
                completion(.success())
                
            } catch {
                print("Realm error:\n\(error)")
                completion(.failure(error))
            }
            
        }
        
    }
    
    func delete(_ movie: Movie, completion: @escaping (Result<Void>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let realm = try self.makeRealm()
                guard let movieEntity = realm.object(ofType: MovieEntity.self, forPrimaryKey: movie.movieID) else {
                    // Not sure if this should be success or failure
                    completion(.failure(NotFoundInContainerError()))
                    return
                }
                
                try realm.write {
                    realm.delete(movieEntity)
                }
                
                completion(.success())
                
            } catch {
                print("Realm error:\n\(error)")
                completion(.failure(error))
            }
            
        }
        
    }
    
    func fetchAll(completion: @escaping (Result<[Movie]>) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                
                let realm = try self.makeRealm()
                let movieEntities = realm.objects(MovieEntity.self)
                
                var movies = [Movie]()
                for entity in movieEntities {
                    movies.append(Movie(movieEntity: entity))
                }
                
                completion(.success(movies))
                
            } catch {
                print("Realm error:\n\(error)")
                completion(.failure(error))
            }
            
        }

    }
    
    func replaceAll(with movies: [Movie], completion: @escaping (Result<Void>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let realm = try self.makeRealm()
                let oldMovieEntities = realm.objects(MovieEntity.self)
                let newMovieEntities = movies.map { MovieEntity(movie: $0) }
                
                try realm.write {
                    realm.delete(oldMovieEntities)
                    realm.add(newMovieEntities)
                }
                
                completion(.success())
                
            } catch {
                print("Realm error:\n\(error)")
                completion(.failure(error))
            }
            
        }
        
    }
    
    func deleteAll(completion: @escaping (Result<Void>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let realm = try self.makeRealm()
                let oldMovieEntities = realm.objects(MovieEntity.self)
                
                try realm.write {
                    realm.delete(oldMovieEntities)
                }
                
                completion(.success())
                
            } catch {
                print("Realm error:\n\(error)")
                completion(.failure(error))
            }
            
        }

    }
    
}
