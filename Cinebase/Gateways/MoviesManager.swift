//
//  MovieManager.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

/**
 This class implements the logic between fetching from the Web API and the local storage.
 */
class MoviesManager {
    
    private let moviesAPIClient: MoviesAPIClient
    private let moviesContainer: MoviesContainer
    private weak var fetchMoviesRequest: WebAPIRequestProtocol?
    
    init(moviesAPIClient: MoviesAPIClient = MoviesAPIClient(), moviesContainer: MoviesContainer = MoviesContainer()) {
        self.moviesAPIClient = moviesAPIClient
        self.moviesContainer = moviesContainer
    }

    /**
     Fetches movies Now Playing from the local storage and / or from the web.
     - Important: This closure can be called more than once if more updated information is found.
    */
    func fetchNowPlaying(completion: @escaping (Result<[Movie]>) -> Void) {
        
        moviesContainer.fetchNowPlaying { [weak self] localResult in
            
            guard let manager = self else { return }
            
            if let localMovies = localResult.value, localMovies.count > 0 {
                completion(.success(localMovies))
            }
            
            manager.fetchNowPlayingFromWeb(localResult: localResult, completion: completion)
        }
        
    }
    
    private func fetchNowPlayingFromWeb(localResult: Result<[Movie]>, completion: @escaping (Result<[Movie]>) -> Void) {
        
        fetchMoviesRequest = moviesAPIClient.fetchNowPlaying { [weak self] webResult in
            
            guard let manager = self else { return }
            
            switch webResult {
            case .failure(let error):
                
                if localResult.error != nil && localResult.value?.count == 0 {
                    // If the container fetch also failed, finish with an error
                    completion(.failure(error))
                } else {
                    // If only the web fails, retry later
                    manager.retryWebFetching(completion: completion)
                }
                
            case .success(let serverMovies):
                
                if let localMovies = localResult.value, serverMovies == localMovies {
                    // If the retrieved movies are the same, there's nothing to update
                    return
                } else {
                    // Update new movies
                    manager.moviesContainer.updateNowPlaying(with: serverMovies)
                    completion(.success(serverMovies))
                }
                
            }
            
        }

    }
    
    private func retryWebFetching(completion: @escaping (Result<[Movie]>) -> Void) {
        // TODO: Implement Network Observer to retry fetching from the web
    }
    
}
