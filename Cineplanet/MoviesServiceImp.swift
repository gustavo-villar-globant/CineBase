//
//  MoviesServiceImp.swift
//  Cineplanet
//
//  Created by Jaime Laino on 4/12/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import Alamofire
import Timberjack

struct MovieServiceImp : MovieService {
    fileprivate let sessionManager: SessionManager = {
        let configuration = Timberjack.defaultSessionConfiguration()
        
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = 10 // seconds
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
    
    func retrieveMovieList(completion: @escaping MoviesInTheatresResponseHandler) {
        sessionManager.request(TheMovieDBService.host + "/movie/now_playing",
                               method: .get,
                               parameters: ["api_key": TheMovieDBService.apiKey],
                               encoding: URLEncoding.default,
                               headers: nil)
            .responseJSON {
                response in
                guard let statusCode = response.response?.statusCode,
                    let value = response.result.value as? NSDictionary,
                    response.result.isSuccess == true else {
                        return completion(NetworkResult.failure(response.result.error!))
                }
                
                switch statusCode {
                case 200:
                    return completion(NetworkResult.success(MoviesInTheatresResponse(json: value)))
                default:
                    return completion(NetworkResult.failure(NSError(domain: "Unkown", code: 400, userInfo: nil)))
                }
        }
    }
}
