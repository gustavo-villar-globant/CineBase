//
//  PlayerTrailerViewController.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/4/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class PlayerTrailerViewController: UIViewController {
    
    
    let id: String
    
    @IBOutlet weak var playerWebView: UIWebView!
    
    init(id: String) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
