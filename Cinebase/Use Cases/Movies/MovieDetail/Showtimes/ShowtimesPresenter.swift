//
//  ShowtimesPresenter.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

protocol ShowtimesPresenterDelegate {
    func showtimesPresenterDidTouchBuyTicketsButton(_ showtimesPresenter: ShowtimesPresenter)
}

class ShowtimesPresenter {
    
    var delegate: ShowtimesPresenterDelegate!
    
    weak var view: ShowtimesView?
    //fileprivate let movie: Movie
    
    init(view: ShowtimesView) {
        self.view = view
    }
    
    func onBuyTicketsButtonPressed() {
        delegate.showtimesPresenterDidTouchBuyTicketsButton(self)
    }
    
}
