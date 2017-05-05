//
//  PlayTrailerRouter.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/4/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class PlayTrailerRouter {
    
    weak var playTrailerViewController: PlayTrailerViewController?
    
    init(_ playTrailerViewController: PlayTrailerViewController) {
        self.playTrailerViewController = playTrailerViewController
    }
    
    static func makeScene(with id: String) -> PlayTrailerViewController {
        
        let viewController = UIStoryboard.playTrailer.instantiate(PlayTrailerViewController.self)
        viewController.id = id
        let router = PlayTrailerRouter(viewController)
        
        return viewController
        
    }
    
}
