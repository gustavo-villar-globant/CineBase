//
//  MoviesListBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class MoviesListBuilder {
    
    let movieDetailBuilder: MovieDetailBuilder
    
    init(movieDetailBuilder: MovieDetailBuilder = MovieDetailBuilder()) {
        self.movieDetailBuilder = movieDetailBuilder
    }
    
    func setupShowDetailTransition(on presenter: MoviesListPresenter, using viewController: MoviesListViewController, and movieDetailBuilder: MovieDetailBuilder) {
        
        presenter.showDetail = { [movieDetailBuilder, weak viewController] movie in
            let detailVC = movieDetailBuilder.makeScene(with: movie)
            viewController?.show(detailVC, sender: nil)
        }
        
    }
    
}
