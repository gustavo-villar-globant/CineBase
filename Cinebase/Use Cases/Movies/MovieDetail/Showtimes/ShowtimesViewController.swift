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

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ShowtimesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

}

extension ShowtimesViewController: ShowtimesView {
    @IBAction func handleBuyTicketsButtonPressed(_ sender: UIButton) {
        presenter.onBuyTicketsButtonPressed()
    }
}

