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
    
}

extension ShowtimesViewController: ShowtimesCellDelegate {
    func cellTapped(sender: ShowtimesCell, tagIndex: Int) {
        let cine = sender.cineData!
        let schedule = sender.schedule[tagIndex]
        print("Cine: \(cine), Horario: \(schedule)")
        presenter.onBuyTicketsButtonPressed()
    }
}
