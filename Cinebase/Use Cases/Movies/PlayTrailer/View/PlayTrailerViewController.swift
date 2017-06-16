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
        
        self.playerView.delegate = self
        //playerView.load(withVideoId: id)
        
        //let vars = {"autoplay" : 1}
        let playerVars = [
            "autohide" : 1,
            "controls" : 0,
            "playsinline" : 1
        ]
        
        playerView.load(withVideoId: id, playerVars: playerVars)
        //playerView.playVideo()
        
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
}

extension PlayTrailerViewController : YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        print("listo")
        playerView.playVideo()
    }
}
