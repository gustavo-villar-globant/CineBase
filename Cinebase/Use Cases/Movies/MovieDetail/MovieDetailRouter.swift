//
//  MovieDetailRouter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import AVKit
import youtube_ios_player_helper

protocol MovieDetailRouterProtocol: class {
    func presentBuyingOptions(for user: User, and movie: Movie)
    func playYoutubeVideo(withKey key: String)
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    weak var movieDetailViewController: MovieDetailViewController?
    
    init(_ movieDetailViewController: MovieDetailViewController) {
        self.movieDetailViewController = movieDetailViewController
    }
    
    static func makeScene(with movie: Movie) -> MovieDetailViewController {
        
        let viewController = UIStoryboard.movieDetail.instantiate(MovieDetailViewController.self)
//        let viewController = MovieDetailViewController()
        let router = MovieDetailRouter(viewController)
        let presenter = MovieDetailPresenter(view: viewController, router: router, movie: movie)
        viewController.presenter = presenter
        router.movieDetailViewController = viewController
        
        return viewController
        
    }
    
    func presentBuyingOptions(for user: User, and movie: Movie) {
        
        let buyTicketViewController = BuyTicketsRouter.makeScene()
        let navigationController = UINavigationController(rootViewController: buyTicketViewController)
        movieDetailViewController?.present(navigationController, animated: true)
        
    }
    
    func playYoutubeVideo(withKey key: String) {
        
//        let playerViewController = UIViewController()
//        
//        let playerView = YTPlayerView(frame: playerViewController.view.frame)
//        
//        playerViewController.view.addSubview(playerView)
//        
//        playerView.load(withVideoId: key)
        
        let vc = PlayTrailerRouter.makeScene(with: key)
        
        let nc = movieDetailViewController?.navigationController
        
        nc?.pushViewController(vc, animated: true)
    }
    
    
}
