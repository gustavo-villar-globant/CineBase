//
//  UpcomingCell.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class UpcomingCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
    }
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    func presentWith(_ model: MovieCellModel) {
        let url = URL(string: model.imagePath)
        movieImageView.setImage(with: url)
        releaseDateLabel.text = model.releaseDate
    }
    
}
