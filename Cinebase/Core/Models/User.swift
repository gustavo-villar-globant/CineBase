//
//  User.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/19/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class User {
    
    let userID: String
    let name: String
    let imagePath: String?
    
    init(userID: String, name: String, imagePath: String? = nil) {
        self.userID = userID
        self.name = name
        self.imagePath = imagePath
    }
}
