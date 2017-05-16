//
//  NowPlayingMoviesListViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class NowPlayingMoviesListViewController: MoviesListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "NowPlayingCell", bundle: nil), forCellWithReuseIdentifier: movieCellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = movieCellModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as! NowPlayingCell
        
        cell.presentWith(model)
        return cell
        
    }
    
}
