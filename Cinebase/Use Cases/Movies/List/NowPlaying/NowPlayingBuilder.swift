//
//  NowPlayingBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

//protocol NowPlayingRouterProtocol: class {
////    func showDetail(of movie: Movie)
//}

class NowPlayingBuilder {
    
    private let movieDetailBuilder: MovieDetailBuilder

    init(movieDetailBuilder: MovieDetailBuilder = MovieDetailBuilder()) {
        self.movieDetailBuilder = movieDetailBuilder
    }
    
    func makeScene(with moviesManagerConfiguration: MoviesManager.Configuration) -> NowPlayingViewController {
        
        let viewController = NowPlayingViewController()
        let presenter = NowPlayingPresenter(view: viewController, moviesManager: MoviesManager(configuration: moviesManagerConfiguration))
        viewController.presenter = presenter
        
        presenter.showDetail = { [movieDetailBuilder] movie in
            let detailVC = movieDetailBuilder.makeScene(with: movie)
            viewController.show(detailVC, sender: nil)
        }
        
        return viewController
        
    }
    
}
