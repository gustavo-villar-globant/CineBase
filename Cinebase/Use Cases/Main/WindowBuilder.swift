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
    
    private let moviesHomeBuilder: MoviesHomeBuilder
    
    init(moviesHomeBuilder: MoviesHomeBuilder = MoviesHomeBuilder()) {
        self.moviesHomeBuilder = moviesHomeBuilder
    }
    
    func makeWindow() -> UIWindow {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let moviesHomeViewController = moviesHomeBuilder.makeScene()
        let navigationController = UINavigationController(rootViewController: moviesHomeViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return window
        
    }
    
}
