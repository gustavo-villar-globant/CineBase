//
//  NowPlayingPresenter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class NowPlayingPresenter {
    
    weak var view: NowPlayingView?
    private let moviesAPIClient: MoviesAPIClient
    private weak var fetchMoviesRequest: WebAPIRequestProtocol?
    private var movies: [Movie] = []
    var showDetail: ((Movie) -> Void)?
    
    init(view: NowPlayingView, moviesAPIClient: MoviesAPIClient = MoviesAPIClient()) {
        self.view = view
        self.moviesAPIClient = moviesAPIClient
    }
    
    func onViewLoad() {
        view?.startLoading()
        fetchMoviesRequest = moviesAPIClient.fetchNowPlaying { [weak self] result in
            
            self?.view?.stopLoading()
            
            switch result {
            case .failure(let error):
                self?.view?.display(error)
            case .success(let movies):
                self?.movies = movies
                let movieCells = movies.map { MovieCellModel(title: $0.title, imagePath: $0.imagePath) }
                self?.view?.displayMovies(movieCells)
            }
            
        }
    }
    
    func onItemSelected(at index: Int) {
        
        guard index < movies.count else {
            fatalError("Selected index does not contain a movie")
        }
        
        let movie = movies[index]
        showDetail?(movie)
        
    }
    
    
    deinit {
        fetchMoviesRequest?.cancel()
    }
    
}
