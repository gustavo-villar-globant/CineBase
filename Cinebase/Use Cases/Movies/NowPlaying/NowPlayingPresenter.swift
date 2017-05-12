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
    private let moviesManager: MoviesManager
    private var movies: [Movie] = []
    var showDetail: ((Movie) -> Void)?
    
    init(view: NowPlayingView, moviesManager: MoviesManager? = nil) {
        self.view = view
        self.moviesManager = moviesManager ?? MoviesManager(source: .nowPlaying, moviesContainer: MoviesContainer(containerName: "NowPlayingMovies"))
    }
    
    func onViewLoad() {
        view?.startLoading()
        fetchNowPlaying()
    }
    
    private func fetchNowPlaying() {
        moviesManager.fetchNowPlaying { [weak self] (result) in
            
            DispatchQueue.main.async {
                
                guard let presenter = self else { return }
                
                presenter.view?.stopLoading()
                
                switch result {
                case .failure(let error):
                    presenter.view?.display(error)
                case .success(let movies):
                    presenter.movies = movies
                    let movieCells = movies.map { MovieCellModel(title: $0.title, imagePath: $0.imagePath) }
                    if presenter.view?.movieCellModels.isEmpty == true {
                        presenter.view?.displayMovies(movieCells)
                    } else {
                        presenter.view?.updateMovies(movieCells)
                    }
                }
                
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

    
}
