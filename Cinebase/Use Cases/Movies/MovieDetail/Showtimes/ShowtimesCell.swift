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

extension ShowtimesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowtimesCollectionCell", for: indexPath) as! ShowtimesCollectionCell
        //cell.scheduleTimeLabel.text = "HOLA"
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
