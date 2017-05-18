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
        
        var dateStyle: Foundation.DateFormatter.Style {
            switch self {
            case .date: return .short
            case .dateTime: return .short
            }
        }
        
        var timeStyle: Foundation.DateFormatter.Style {
            switch self {
            case .date: return .none
            case .dateTime: return .short
            }
        }
    }
    
    private let formatter = Foundation.DateFormatter()
    
    func format(_ date: Date, style: Style) -> String {
        formatter.dateStyle = style.dateStyle
        formatter.timeStyle = style.timeStyle
        return formatter.string(from: date)
    }
    
}
