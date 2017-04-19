//
//  BuyTicketsRouter.swift
//  Cineplanet
//
//  Created by Gustavo Villar on 4/19/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

protocol BuyTicketsRouterProtocol: class {
    func dismiss()
}

class BuyTicketsRouter: BuyTicketsRouterProtocol {
    
    static func makeScene() -> UIViewController {
        
        let viewController = BuyTicketsViewController()
        let router = BuyTicketsRouter()
        let presenter = BuyTicketsPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
