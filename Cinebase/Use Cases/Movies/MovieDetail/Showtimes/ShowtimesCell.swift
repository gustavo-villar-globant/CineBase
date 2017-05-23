//
//  ShowtimesCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class ShowtimesCell: UITableViewCell {
    
    @IBOutlet weak var cinemaLabel: UILabel!
    
   
    @IBOutlet weak var scheduleSelectionControl: TagsSelectionControl!
    
    let schedule = ["2:00 pm","3:00 pm","4:00 pm"]
    
    var cineData: String? {
        didSet {
            cinemaLabel.text = cineData
        }
    }
    
    override func awakeFromNib() {
        setupScheduleSelectionControl(with: schedule)
    }
    
    func setupScheduleSelectionControl(with schedule: [String]) {
        scheduleSelectionControl.spacing = 5
        scheduleSelectionControl.labels = schedule
        //scheduleSelectionControl.cornerRadius = 10
        scheduleSelectionControl.tagBackgroundColor = .gray
        scheduleSelectionControl.tagSelectedBackgroundColor = .red
    }
    
}

