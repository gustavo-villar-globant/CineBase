//
//  ShowtimesScheduleCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import TagListView

class ShowtimesScheduleCell: UITableViewCell {
    
    @IBOutlet weak var daySelectionControl: DaySelectionControl!
    
    let days = ["Lun 15 May","Mar 16 May","Mie 17 May"]
    
    override func awakeFromNib() {
        
        //let size = CGSize(width: self.bounds.height, height: self.bounds.height)
        
        daySelectionControl.dayLabels = days
        
    }
}


