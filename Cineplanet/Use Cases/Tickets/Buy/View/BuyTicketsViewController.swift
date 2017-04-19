//
//  BuyTicketsViewController.swift
//  Cineplanet
//
//  Created by Gustavo Villar on 4/19/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

protocol BuyTicketsView: class {
}

class BuyTicketsViewController: UIViewController, BuyTicketsView {
    
    var presenter: BuyTicketsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tickets"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
    }
    
    func cancel(_ sender: AnyObject) {
        presenter?.onCancelTouched()
    }
    
}
