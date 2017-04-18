//
//  NowPlayingTableViewDelegate.swift
//  Cineplanet
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

extension NowPlayingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = movieCellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath)
        cell.textLabel?.text = model.title
        
        return cell
        
    }

}

extension NowPlayingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.onItemSelected(at: indexPath.row)
    }
    
}
