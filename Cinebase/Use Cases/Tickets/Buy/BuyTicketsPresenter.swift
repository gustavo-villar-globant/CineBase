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
    
    init(view: BuyTicketsView) {
        self.view = view
    }
    
    var dismiss: (() -> Void)?
    
    func onCancelTouched() {
        dismiss?()
    }
    
    func onCreditCardScanned(withNumber cardNumber: String, expiryMonth: Int, expiryYear: Int, cvv: String) {
        let description = "Received card info.\n" +
                        "Number: \(cardNumber)\n" +
                        "expiry: \(expiryMonth)/\(expiryYear)\n" +
                        "cvv: \(cvv)"
        view?.setDescription(description)

    }
    
}
