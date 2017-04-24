//
//  NowPlayingCell.swift
//  Cinebase
//
//  Created by Charles Moncada on 23/04/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import Kingfisher

private let imageBaseURL =  "https://image.tmdb.org/t/p/w500"

class NowPlayingCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func presentWith(_ model: MovieCellModel) {
        
        self.movieLabel.text = model.title
        let urlString = imageBaseURL + model.imageURL
        let url = URL(string: urlString)
        movieImage.kf.setImage(with: url)
    }
    
    
}
