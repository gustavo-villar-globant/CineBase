//
//  WindowBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

struct WindowBuilder {
    
    private let nowPlayingBuilder: NowPlayingBuilder
    
    init(nowPlayingBuilder: NowPlayingBuilder = NowPlayingBuilder()) {
        self.nowPlayingBuilder = nowPlayingBuilder
    }
    
    func makeWindow() -> UIWindow {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let nowPlayingViewController = nowPlayingBuilder.makeScene()
        let navigationController = UINavigationController(rootViewController: nowPlayingViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return window
        
    }
    
}
