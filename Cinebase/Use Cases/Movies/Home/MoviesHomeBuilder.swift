//
//  MoviesHomeBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class MoviesHomeBuilder {
    
    let nowPlayingMoviesListBuilder: NowPlayingMoviesListBuilder
    let upcomingMoviesListBuilder: UpcomingMoviesListBuilder
    
    init(nowPlayingMoviesListBuilder: NowPlayingMoviesListBuilder = NowPlayingMoviesListBuilder(), upcomingMoviesListBuilder: UpcomingMoviesListBuilder = UpcomingMoviesListBuilder()) {
        self.nowPlayingMoviesListBuilder = nowPlayingMoviesListBuilder
        self.upcomingMoviesListBuilder = upcomingMoviesListBuilder
    }
    
    func makeScene() -> MoviesHomeViewController {
        
        let viewController = MoviesHomeViewController()
        viewController.moviesViewControllers = [
            nowPlayingMoviesListBuilder.makeScene(),
            upcomingMoviesListBuilder.makeScene()
        ]
        
        return viewController
        
    }
    
}
