//
//  PlayTrailerBuilder.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/5/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

//protocol NowPlayingRouterProtocol: class {
////    func showDetail(of movie: Movie)
//}

class PlayTrailerBuilder {
    
    
    func makeScene(with key: String) -> PlayTrailerViewController {
        
        let viewController = UIStoryboard.playTrailer.instantiate(PlayTrailerViewController.self)
        viewController.id = key
        
        return viewController
        
    }
    
}
