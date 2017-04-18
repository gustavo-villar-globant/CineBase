//
//  MovieDetailRouter.swift
//  Cineplanet
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

protocol MovieDetailRouterProtocol: class {
    
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    static func makeScene(with movie: Movie) -> MovieDetailViewController {
        
        let viewController = MovieDetailViewController()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(view: viewController, router: router, movie: movie)
        viewController.presenter = presenter
        
        return viewController
        
    }
    
}
