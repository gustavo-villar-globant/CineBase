//
//  StoryboardLoader.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/21/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static let movieDetail = UIStoryboard(name: "MovieDetail", bundle: nil)
    
    open func instantiate<T: UIViewController>(_ type: T.Type, named name: String? = nil) -> T {
        let identifier = name ?? String(describing: T.self)
        guard let viewController = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Unable to load \(identifier) from storyboard")
        }
        return viewController
    }
}
