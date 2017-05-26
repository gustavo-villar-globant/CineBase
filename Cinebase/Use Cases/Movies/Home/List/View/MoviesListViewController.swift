//
//  MoviesListViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

struct MovieCellModel: Equatable {
    var title: String
    var imagePath: String
    var releaseDate: String
    
    static func ==(lhs: MovieCellModel, rhs: MovieCellModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.imagePath == rhs.imagePath &&
            lhs.releaseDate == rhs.releaseDate
    }
}

protocol MoviesListView: class {
    func startLoading()
    func stopLoading()
    var movieCellModels: [MovieCellModel] { get }
    func displayMovies(_ movieCellModels: [MovieCellModel])
    func updateMovies(_ movieCellModels: [MovieCellModel])
    func display(_ error: Error)
}

class MoviesListViewController: UIViewController {
    
    var presenter: MoviesListPresenter!
    
    fileprivate(set) var movieCellModels: [MovieCellModel] = []
    let movieCellIdentifier = "MovieCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    fileprivate weak var loadingView: UIActivityIndicatorView?
    
    override func loadView() {
        let xibName = String(describing: MoviesListViewController.self)
        view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)!.first as! UIView
    }

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
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupCollectionView() {
        collectionView.alpha = 0
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Now Playing View
extension MoviesListViewController: MoviesListView {
    
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
        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}
