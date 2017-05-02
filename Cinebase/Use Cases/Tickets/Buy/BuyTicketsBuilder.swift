//
//  BuyTicketsBuilder.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/19/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

//protocol BuyTicketsRouterProtocol: class {
////    func dismiss()
//}

class BuyTicketsBuilder {
    
    func makeScene(user: User, movie: Movie) -> BuyTicketsViewController {
        
        let viewController = BuyTicketsViewController()
        let presenter = BuyTicketsPresenter(view: viewController)
        viewController.presenter = presenter
        presenter.dismiss = {
            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        return viewController
    }
    
}
