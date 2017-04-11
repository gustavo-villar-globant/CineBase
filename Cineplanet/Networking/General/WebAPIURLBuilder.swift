//
//  WebAPIURLBuilder.swift
//  Cineplanet
//
//  Created by Gustavo Villar on 4/11/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

/**
 Builder for URLs that target the Web API endpoints.
 In the future, it will use the environment variable to
 switch to different base URLs.
*/
struct WebAPIURLBuilder {
    
    private static let baseURL = "https://api.domain.com"
    
    static func url(forPath path: String, queryParameters: [String: Any]? = nil) -> URL {
        
        var query = ""
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            query = "?"
            query += queryParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        
        return URL(string: baseURL + path + query)!
        
    }
    
}
