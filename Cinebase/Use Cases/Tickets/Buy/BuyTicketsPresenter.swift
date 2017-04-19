//
//  BuyTicketsPresenter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/19/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class BuyTicketsPresenter {
    
    weak var view: BuyTicketsView?
    private let router: BuyTicketsRouterProtocol
    
    init(view: BuyTicketsView, router: BuyTicketsRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func onCancelTouched() {
        router.dismiss()
    }
    
}
