//
//  NowPlayingCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 23/04/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class NowPlayingCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
    }
    
    func presentWith(_ model: MovieCellModel) {
        let url = URL(string: model.imagePath)
        movieImageView.setImage(with: url)
    }
    
}
