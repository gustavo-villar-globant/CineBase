//
//  UpcomingMoviesListViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class UpcomingMoviesListViewController: MoviesListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "UpcomingCell", bundle: nil), forCellWithReuseIdentifier: movieCellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = movieCellModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as! UpcomingCell
        
        cell.presentWith(model)
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        size.height += 40
        return size
        
    }

}
