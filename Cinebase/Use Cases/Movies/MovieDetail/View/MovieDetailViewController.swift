//
//  MovieDetailViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/18/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

// MARK: MovieViewModel Definition
struct MovieViewModel: Equatable {
    var title: String
    var backdropPath: String
    var overview: String
    
    static func ==(lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.backdropPath == rhs.backdropPath &&
            lhs.overview == rhs.overview
    }
}

// MARK: MovieDetailView Protocol Definition
protocol MovieDetailView: class, LoginView {
    func display(_ movieViewModel: MovieViewModel)
}

// MARK: MovieDetailViewController
class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenter!
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var selectViewSegmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    
    var overViewText: String!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.onViewLoad()
        setupContainerView()
    }
    
    // MARK: Setup
    func setupContainerView() {
        let vc = ShowtimesBuilder().makeScene()
        vc.presenter.delegate = self.presenter
        self.currentViewController = vc
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.containerView)
    }
    
    // MARK: IBAction
    
    @IBAction func selectionDidChange(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            let newViewController = ShowtimesBuilder().makeScene()
            newViewController.presenter.delegate = self.presenter
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController)
            self.currentViewController = newViewController
        } else {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            newViewController.text = overViewText
            newViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController)
            self.currentViewController = newViewController
        }

    }
    
    
    
    @IBAction func handlePlayTrailer(_ sender: Any) {
        presenter.onPlayTrailerButtonPressed()
    }
    
    // MARK: Utils Methods
    
    func addSubview(_ subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       animations: {
                        newViewController.view.alpha = 1
                        oldViewController.view.alpha = 0
        },
                       completion: { finished in
                        oldViewController.view.removeFromSuperview()
                        oldViewController.removeFromParentViewController()
                        newViewController.didMove(toParentViewController: self)
        })
    }
    
    
    
}

// MARK: MovieDetailView Protocol
extension MovieDetailViewController: MovieDetailView {
    func display(_ movieViewModel: MovieViewModel) {
        title = movieViewModel.title
        overViewText = movieViewModel.overview
        let url = URL(string: movieViewModel.backdropPath)
        backdropImageView.setImage(with: url)
    }
}


// MARK: Login View
extension MovieDetailViewController {
    func presentLogin(_ loginViewController: UIViewController) {
        present(loginViewController, animated: true)
    }
}
