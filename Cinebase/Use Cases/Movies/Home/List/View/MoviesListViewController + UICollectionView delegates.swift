//
//  MoviesListViewController + UICollectionView delegates.swift
//  Cinebase
//
//  Created by Charles Moncada on 23/04/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

extension MoviesListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCellModels.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Override method collectionView(_:cellForItemAt:) on MoviesListViewController subclass")
    }
    
    
}

extension MoviesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.onItemSelected(at: indexPath.row)
    }
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns = (view.bounds.width > 700) ? 3 : 2 // 3 columns for plus models
        
        let horizontalMargins = collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right
        let cellSpacing = collectionViewFlowLayout.minimumInteritemSpacing * CGFloat(numberOfColumns - 1)
        let width = (view.bounds.width - horizontalMargins - cellSpacing) / CGFloat(numberOfColumns)
        let height = width / 27 * 41 // 27" X 41" is the standard movie poster size
        
        return CGSize(width: width, height: height)
        
    }
    
}
