//
//  NowPlayingRouter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

protocol NowPlayingRouterProtocol: class {
    func showDetail(of movie: Movie)
}

class NowPlayingRouter: NowPlayingRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(_ nowPlayingViewController: UIViewController) {
        self.viewController = nowPlayingViewController
    }
    
    func showDetail(of movie: Movie) {
        let detailVC = MovieDetailRouter.makeScene(with: movie)
        viewController?.show(detailVC, sender: nil)
    }
    
    static func makeScene() -> NowPlayingViewController {
        
        let viewController = NowPlayingViewController()
        let router = NowPlayingRouter(viewController)
        let presenter = NowPlayingPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
        
    }
    
}
