//
//  RealmConfigurator.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfigurator {
    
    enum Directory {
        case cache
        case temporal
        case documents
        
        var url: URL {
            let path: String
            switch self {
            case .cache:
                path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
            case .temporal:
                path = NSTemporaryDirectory()
            case .documents:
                path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            }
            return URL(string: path)!
        }
    }
    
    func makeRealm(on directory: Directory = .documents, named name: String = "Container") throws -> Realm {
        let url = directory.url.appendingPathComponent("\(name).realm")
        let config = Realm.Configuration(fileURL: url)
        return try Realm(configuration: config)
    }
    
    
}
