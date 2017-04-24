//
//  NowPlayingCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 23/04/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import Kingfisher

class NowPlayingCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func presentWith(_ model: MovieCellModel) {
        
        self.movieLabel.text = model.title
        let url = URL(string: model.imagePath)
        movieImage.kf.setImage(with: url)
    }
    
    
}
