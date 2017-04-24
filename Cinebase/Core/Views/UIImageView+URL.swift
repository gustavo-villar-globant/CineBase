//
//  UIImageView+URL.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?) {
        kf.setImage(with: url)
    }
    
}
