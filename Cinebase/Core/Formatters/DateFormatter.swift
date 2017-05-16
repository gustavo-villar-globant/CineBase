//
//  DateFormatter.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class DateFormatter {
    
    enum Style {
        case date
        case dateTime
    }
    
    private let formatter = Foundation.DateFormatter()
    
    func format(_ date: Date, style: Style) -> String {
        switch style {
        case .date:
            formatter.dateStyle = .short
            formatter.timeStyle = .none
        case .dateTime:
            formatter.dateStyle = .short
            formatter.timeStyle = .short
        }
        return formatter.string(from: date)
    }
    
}
