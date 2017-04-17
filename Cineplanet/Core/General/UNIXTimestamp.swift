//
//  UNIXTimestamp.swift
//  Cineplanet
//
//  Created by Gustavo Villar on 4/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

extension Date {
    
    var unixTimestamp: TimeInterval {
        return timeIntervalSince1970 * 1_000
    }
    
    init(unixTimestamp: TimeInterval) {
        self = Date(timeIntervalSince1970: unixTimestamp / 1_000)
    }
    
}
