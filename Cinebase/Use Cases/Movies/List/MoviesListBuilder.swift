//
//  MoviesListBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class MoviesListBuilder {
    
    let nowPlayingBuilder: NowPlayingBuilder
    
    init(nowPlayingBuilder: NowPlayingBuilder = NowPlayingBuilder()) {
        self.nowPlayingBuilder = nowPlayingBuilder
    }
    
    func makeScene() -> MoviesListViewController {
        
        let viewController = MoviesListViewController()
        viewController.moviesViewControllers = [nowPlayingBuilder.makeScene(with: .nowPlaying), nowPlayingBuilder.makeScene(with: .upcoming)]
        
        return viewController
        
    }
    
}
