//
//  NowPlayingMoviesListBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class NowPlayingMoviesListBuilder: MoviesListBuilder {
    
    func makeScene() -> NowPlayingMoviesListViewController {
        
        let viewController = NowPlayingMoviesListViewController()
        viewController.title = "Now Playing"
        let presenter = NowPlayingMoviesListPresenter(view: viewController)
        viewController.presenter = presenter
        
        setupShowDetailTransition(on: presenter, using: viewController, and: movieDetailBuilder)
        
        return viewController
        
    }
    
}
