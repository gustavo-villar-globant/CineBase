//
//  MoviesListViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    private var selectedChildController: UIViewController?
    var moviesViewControllers: [NowPlayingViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstViewController = moviesViewControllers.first {
            setupSelectedChildController(firstViewController, animated: false)
        }
    }
    
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        let selectedChildController = moviesViewControllers[segmentedControl.selectedSegmentIndex]
        setupSelectedChildController(selectedChildController, animated: true)
    }
    
    private func setupSelectedChildController(_ newChildController: UIViewController, animated: Bool) {
        
        let oldChildController = selectedChildController
        selectedChildController = newChildController
        
        addChildViewController(newChildController)
        oldChildController?.willMove(toParentViewController: nil)
        
        let newView = newChildController.view!
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)
        
        newView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        newView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        newView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        newView.alpha = 0
        
        let oldView = oldChildController?.view
        
        let duration = animated ? 0.5 : 0
        UIView.animate(withDuration: duration, animations: { [weak newView, weak oldView] in
            newView?.alpha = 1
            oldView?.alpha = 0
        }, completion: {
            [weak self, weak oldView,
            weak oldChildController,
            weak newChildController] _ in
            oldView?.removeFromSuperview()
            oldChildController?.removeFromParentViewController()
            newChildController?.didMove(toParentViewController: self)
        })
        
    }

}
