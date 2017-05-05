//
//  PlayTrailerViewController.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/4/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayTrailerViewController: UIViewController {
    
    
    var id: String!
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        
        playerView.load(withVideoId: id)
        
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
}
