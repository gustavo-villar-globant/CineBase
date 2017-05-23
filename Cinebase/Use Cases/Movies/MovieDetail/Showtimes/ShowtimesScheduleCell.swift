//
//  ShowtimesScheduleCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class ShowtimesScheduleCell: UITableViewCell {
    
    @IBOutlet weak var daySelectionControl: TagsSelectionControl!
    
    let days = ["Lun 15 May","Mar 16 May"]
    
    override func awakeFromNib() {
        
        setupDaySelectionControl(with: days)

    }
    
    func setupDaySelectionControl(with days: [String]) {   
        daySelectionControl.spacing = 10
        daySelectionControl.labels = days
        daySelectionControl.squareTags = true
        daySelectionControl.cornerRadius = 10
        daySelectionControl.tagBackgroundColor = .blue
        daySelectionControl.tagSelectedBackgroundColor = .green
        daySelectionControl.selectedViewIndex = 0
        
    }
    
    @IBAction func daySelectionValueChanged(_ sender: TagsSelectionControl) {
        
        print(sender.selectedViewIndex)
    }
}



