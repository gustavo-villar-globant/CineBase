//
//  MovieDetailRouter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol: class {
    func presentBuyingOptions(for user: User, and movie: Movie)
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
    
}
