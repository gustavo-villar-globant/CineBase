//
//  ShowtimesBuilder.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class ShowtimesBuilder {
    
    func makeScene(with delegate:ShowtimesPresenterDelegate) -> ShowtimesViewController {
        
        let viewController = UIStoryboard.movieDetail.instantiateViewController(withIdentifier: "ShowtimesViewController") as! ShowtimesViewController
        let presenter = ShowtimesPresenter(view: viewController)
        presenter.delegate = delegate
        viewController.presenter = presenter
        
        return viewController
        
    }
    
}
