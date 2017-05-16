//
//  UpcomingMoviesListBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class UpcomingMoviesListBuilder: MoviesListBuilder {
    
    func makeScene() -> UpcomingMoviesListViewController {
        
        let viewController = UpcomingMoviesListViewController()
        viewController.title = "Upcoming"
        let presenter = UpcomingMoviesListPresenter(view: viewController)
        viewController.presenter = presenter
        
        setupShowDetailTransition(on: presenter, using: viewController, and: movieDetailBuilder)
        
        return viewController
        
    }
    
}
