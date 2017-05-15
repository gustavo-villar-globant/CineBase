//
//  NowPlayingPresenter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class NowPlayingPresenter: MoviesListPresenter {
    
    override init(view: NowPlayingView, moviesManager: MoviesManager = MoviesManager(configuration: .nowPlaying)) {
        super.init(view: view, moviesManager: moviesManager)
    }
    
}
