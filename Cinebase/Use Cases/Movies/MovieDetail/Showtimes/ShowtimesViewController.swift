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
    func handleBuyTicketsButtonPressed(_ sender: UITableViewCell)
}

class ShowtimesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ShowtimesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }

}

extension ShowtimesViewController: ShowtimesView {
    func handleBuyTicketsButtonPressed(_ sender: UITableViewCell) {
        presenter.onBuyTicketsButtonPressed()
    }
}

extension ShowtimesViewController: ShowtimesCellDelegate {
    func cellTapped(sender: ShowtimesCell, schedule: String) {
        let cine = sender.cineData!
        print("Cine: \(cine), Horario: \(schedule)")
        handleBuyTicketsButtonPressed(sender)
    }
}
