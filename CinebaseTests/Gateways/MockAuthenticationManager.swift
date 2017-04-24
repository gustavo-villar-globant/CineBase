//
//  MockAuthenticationManager.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
@testable import Cinebase

class MockAuthenticationManager: AuthenticationManagerProtocol {
    
    weak var delegate: AuthenticationManagerDelegate?
    
    private(set) var isRequestingLoginWithGoogle = false
    func requestLoginWithGoogle(from viewController: LoginView) {
        isRequestingLoginWithGoogle = true
    }
    
}
