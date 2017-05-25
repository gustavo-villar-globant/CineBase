//
//  ShowtimesCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

protocol ShowtimesCellDelegate: class {
    func cellTapped(sender: ShowtimesCell, tagIndex: Int)
}

class ShowtimesCell: UITableViewCell {
    
    @IBOutlet weak var cinemaLabel: UILabel!
   
    @IBOutlet weak var scheduleSelectionControl: TagsSelectionControl!
    
    let schedule = ["21:40","22:40"]
    
    var delegate: ShowtimesCellDelegate?
    
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
        
        scheduleSelectionControl.tagHeight = 25
        scheduleSelectionControl.paddingX = 10
        
        scheduleSelectionControl.cornerRadius = 5
        scheduleSelectionControl.tagBackgroundColor = .orange
        scheduleSelectionControl.tagSelectedBackgroundColor = .red
    }
    
    @IBAction func scheduleSelectionTapped(_ sender: TagsSelectionControl) {
        //let schedule = sender.tagViews[sender.selectedViewIndex].tagNameLabel.text!
        delegate?.cellTapped(sender: self, tagIndex: sender.selectedViewIndex)
        sender.resetTags()
    }
    
    override func prepareForReuse() {
        scheduleSelectionControl.resetTags()
    }
}

