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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cineData: String? {
        didSet {
            cinemaLabel.text = cineData
        }
    }
    
    override func awakeFromNib() {
        
    }
}
