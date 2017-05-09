//
//  NowPlayingViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

struct MovieCellModel: Equatable {
    var title: String
    var imagePath: String
    
    static func ==(lhs: MovieCellModel, rhs: MovieCellModel) -> Bool {
        return lhs.title == rhs.title && lhs.imagePath == rhs.imagePath
    }
}

protocol NowPlayingView: class {
    func startLoading()
    func stopLoading()
    var movieCellModels: [MovieCellModel] { get }
    func displayMovies(_ movieCellModels: [MovieCellModel])
    func updateMovies(_ movieCellModels: [MovieCellModel])
    func display(_ error: Error)
}

class NowPlayingViewController: UIViewController {
    
    var presenter: NowPlayingPresenter!
    
    fileprivate(set) var movieCellModels: [MovieCellModel] = []
    let movieCellIdentifier = "MovieCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate weak var loadingView: UIActivityIndicatorView?

    override func viewDidLoad() {
        setupSubviews()
        presenter.onViewLoad()
    }
    
    private func setupSubviews() {
        setupNavigationItem()
        setupCollectionView()
    }
    
    private func setupNavigationItem() {
        title = "Now Playing"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupCollectionView() {
        collectionView.alpha = 0
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "NowPlayingCell", bundle: nil), forCellWithReuseIdentifier: movieCellIdentifier)
    }
}

// MARK: - Now Playing View
extension NowPlayingViewController: NowPlayingView {
    
    private func setupLoadingViewIfNeeded() -> UIActivityIndicatorView {
        if let loadingView = loadingView {
            return loadingView
        } else {
            
            let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            
            loadingView.color = .gray
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(loadingView)
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            self.loadingView = loadingView
            return loadingView
            
        }
    }
    
    func startLoading() {
        
        let loadingView = setupLoadingViewIfNeeded()
        loadingView.alpha = 0
        loadingView.startAnimating()
        
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: { [weak loadingView] in
            loadingView?.alpha = 1
        }, completion: nil)
        
    }
    
    func stopLoading() {
        
        guard let loadingView = loadingView else { return }
        self.loadingView = nil
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: { [weak loadingView] in
            loadingView?.alpha = 0
        }, completion: { (completed) in
            loadingView.removeFromSuperview()
        })
        
    }
    
    func displayMovies(_ movieCellModels: [MovieCellModel]) {
        
        self.movieCellModels = movieCellModels
        
        collectionView.reloadData()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.collectionView.alpha = 1
        }
    }
    
    func updateMovies(_ movieCellModels: [MovieCellModel]) {
        self.movieCellModels = movieCellModels
        collectionView.reloadSections([0])
    }
    
    func display(_ error: Error) {
        
    }
    
}
