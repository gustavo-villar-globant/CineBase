//
//  MoviesListPresenter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

/**
 Base class for NowPlaying and Upcoming presenters.
*/
class MoviesListPresenter {
    
    weak var view: MoviesListView?
    private let moviesManager: MoviesManager
    private var movies: [Movie] = []
    var showDetail: ((Movie) -> Void)?
    
    init(view: MoviesListView, moviesManager: MoviesManager) {
        self.view = view
        self.moviesManager = moviesManager
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
                    let formatter = DateFormatter()
                    let movieCells = movies.map { MovieCellModel(title: $0.title, imagePath: $0.imagePath, releaseDate: formatter.format($0.releaseDate, style: .date)) }
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
