//
//  ShowtimesScheduleCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class ShowtimesScheduleCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        
    }
}

extension ShowtimesScheduleCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowtimesScheduleCollectionCell", for: indexPath) as! ShowtimesScheduleCollectionCell
        cell.scheduleTimeLabel.text = "HOLA"
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
