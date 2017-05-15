//
//  UpcomingPresenter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class UpcomingPresenter: MoviesListPresenter {
    
    override init(view: NowPlayingView, moviesManager: MoviesManager = MoviesManager(configuration: .upcoming)) {
        super.init(view: view, moviesManager: moviesManager)
    }

}
