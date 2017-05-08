//
//  MovieDetailViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

struct MovieViewModel: Equatable {
    var title: String
    var movieID: Int
    var backdropPath: String
    var overview: String
    
    static func ==(lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.backdropPath == rhs.backdropPath &&
            lhs.overview == rhs.overview
    }
}

protocol MovieDetailView: class, LoginView {
    func display(_ movieViewModel: MovieViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailView {
    
    var presenter: MovieDetailPresenter!
    
    
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    var movieID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        edgesForExtendedLayout = []
        presenter.onViewLoad()
    }
    
    func display(_ movieViewModel: MovieViewModel) {
        title = movieViewModel.title
        movieID = movieViewModel.movieID
        overviewTextView.text = movieViewModel.overview
        let url = URL(string: movieViewModel.backdropPath)
        backdropImageView.setImage(with: url)
        
    }
    
    @IBAction func buyTickets(_ sender: Any) {
        presenter.buyTickets()
    }
    
    @IBAction func handlePlayTrailer(_ sender: Any) {
        if let movieID = movieID {
            presenter.playTrailerwithID(movieID)
        }
    }
    
    
}

// MARK: - Login View
extension MovieDetailViewController {
    func presentLogin(_ loginViewController: UIViewController) {
        present(loginViewController, animated: true)
    }
}
