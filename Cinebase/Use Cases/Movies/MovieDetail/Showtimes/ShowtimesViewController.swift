//
//  ShowtimesViewController.swift
//  Cinebase
//
//  Created by Charles Moncada on 10/05/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit


// MARK: ShowtimesView Protocol Definition
protocol ShowtimesView: class {
    func handleBuyTicketsButtonPressed(_ sender: UIButton)
}

class ShowtimesViewController: UIViewController {

    //var delegate: ShowtimesViewControllerDelegate!
    var presenter: ShowtimesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ShowtimesViewController: ShowtimesView {
    @IBAction func handleBuyTicketsButtonPressed(_ sender: UIButton) {
        presenter.onBuyTicketsButtonPressed()
    }
}

