//
//  ShowtimesScheduleCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class ShowtimesScheduleCell: UITableViewCell {
    
    @IBOutlet weak var daySelectionControl: ButtonsArraySelectionControl!
    
    let days = ["Lun 15 May","Mar 16 May","Mie 17 May"]
    
    override func awakeFromNib() {
        
        daySelectionControl.labels = days
        
    }
}


