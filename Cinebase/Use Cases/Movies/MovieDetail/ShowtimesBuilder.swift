//
//  ShowtimesBuilder.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class ShowtimesBuilder {
    
    func makeScene() -> ShowtimesViewController {
        
        let viewController = UIStoryboard.movieDetail.instantiateViewController(withIdentifier: "ShowtimesViewController") as! ShowtimesViewController
        let presenter = ShowtimesPresenter(view: viewController)
        viewController.presenter = presenter
        
        
        return viewController
        
    }
    
}
