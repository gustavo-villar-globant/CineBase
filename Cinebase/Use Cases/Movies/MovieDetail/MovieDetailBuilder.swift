//
//  MovieDetailBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

//protocol MovieDetailRouterProtocol: class {
////    func presentBuyingOptions(for user: User, and movie: Movie)
//}

class MovieDetailBuilder {
    
    private let buyTicketsBuilder: BuyTicketsBuilder
    private let playTrailerBuilder: PlayTrailerBuilder
    
    init(buyTicketsBuilder: BuyTicketsBuilder = BuyTicketsBuilder(), playTrailerBuilder: PlayTrailerBuilder = PlayTrailerBuilder() ) {
        self.buyTicketsBuilder = buyTicketsBuilder
        self.playTrailerBuilder = playTrailerBuilder
    }
    
    func makeScene(with movie: Movie) -> MovieDetailViewController {
        
        let viewController = UIStoryboard.movieDetail.instantiate(MovieDetailViewController.self)
        let presenter = MovieDetailPresenter(view: viewController, movie: movie)
        viewController.presenter = presenter
        
        presenter.presentBuyingOptions = { [buyTicketsBuilder] (user, movie) in
            
            let buyTicketVC = buyTicketsBuilder.makeScene(user: user, movie: movie)
            let navigationController = UINavigationController(rootViewController: buyTicketVC)
            viewController.present(navigationController, animated: true)
            
        }
        
        presenter.playYoutubeVideoWithKey = { [playTrailerBuilder] (key) in
            let playTrailerVC = playTrailerBuilder.makeScene(with: key)
            viewController.navigationController?.pushViewController(playTrailerVC, animated: true)
            
        }
        
        return viewController
        
    }
    
}
