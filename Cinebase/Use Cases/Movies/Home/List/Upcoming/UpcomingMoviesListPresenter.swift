//
//  UpcomingMoviesListPresenter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class UpcomingMoviesListPresenter: MoviesListPresenter {
    
    override init(view: MoviesListView, moviesManager: MoviesManager = MoviesManager(configuration: .upcoming)) {
        super.init(view: view, moviesManager: moviesManager)
    }

}
