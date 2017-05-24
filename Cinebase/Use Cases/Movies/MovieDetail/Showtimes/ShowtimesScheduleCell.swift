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
    
    let days = ["Lun 15 May","Mar 16 May", "Mie 17 May", "Jue 18 May", "Vie 19 May"]
    
    override func awakeFromNib() {
        setupDaySelectionControl(with: days)
    }
    
    func setupDaySelectionControl(with days: [String]) {   
        //Pre-settings
        daySelectionControl.spacing = 10
        
        // Tags to show
        daySelectionControl.labels = days
        
        // Tag dimensions settings
        daySelectionControl.tagHeight = 50
        daySelectionControl.hasSquareTags = true
        
        // Tag appearance settings
        daySelectionControl.cornerRadius = 10
        daySelectionControl.tagBackgroundColor = .gray
        daySelectionControl.tagSelectedBackgroundColor = .orange
        daySelectionControl.selectedTextColor = .white
        daySelectionControl.selectedViewIndex = 0
        
    }
    
    @IBAction func daySelectionValueChanged(_ sender: TagsSelectionControl) {
        
        print("Horario Seleccionado: \(sender.labels[sender.selectedViewIndex])")
        
    }
}



