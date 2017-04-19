//
//  MainRouter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

struct MainRouter {
    
    static func makeWindow() -> UIWindow {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let nowPlayingViewController = NowPlayingRouter.makeScene()
        let navigationController = UINavigationController(rootViewController: nowPlayingViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return window
        
    }
    
}
