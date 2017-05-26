//
//  ShowtimesViewController + UITableViewDelegates.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

extension ShowtimesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "ShowtimesScheduleCell", for: indexPath) as! ShowtimesScheduleCell
        } else {
            let showtimeCell = tableView.dequeueReusableCell(withIdentifier: "ShowtimesCell", for: indexPath) as! ShowtimesCell
            showtimeCell.cineData = "Cine \(indexPath.row + 1)"
            showtimeCell.delegate = self
            cell = showtimeCell
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : section == 1 ? "Favorites" : "Near me"
    }
    
}
