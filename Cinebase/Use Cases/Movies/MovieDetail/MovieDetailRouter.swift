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
    
    weak var viewController: UIViewController?
    
    static func makeScene(with movie: Movie) -> MovieDetailViewController {
        
        let viewController = MovieDetailViewController()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(view: viewController, router: router, movie: movie)
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
        
    }
    
    func presentBuyingOptions(for user: User, and movie: Movie) {
        
        let buyTicketViewController = BuyTicketsRouter.makeScene()
        let navigationController = UINavigationController(rootViewController: buyTicketViewController)
        viewController?.present(navigationController, animated: true)
        
    }
    
}
