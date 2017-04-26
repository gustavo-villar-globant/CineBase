//
//  JSONFileReader.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/26/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

class JSONFileReader {
    
    struct FileNotFoundError: Error, CustomDebugStringConvertible {
        let fileName: String
        var debugDescription: String {
            return "JSON file \(fileName) not found"
        }
    }
    
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func json() throws -> Any {
        
        guard let filePath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
                throw FileNotFoundError(fileName: fileName)
        }
        do {
            let data = try NSData(contentsOfFile: filePath) as Data
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json
        }
        
    }
}
