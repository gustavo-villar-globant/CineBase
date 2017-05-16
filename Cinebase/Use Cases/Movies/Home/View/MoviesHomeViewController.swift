//
//  MoviesHomeViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MoviesHomeViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    private var selectedChildController: MoviesListViewController?
    var moviesViewControllers: [MoviesListViewController] = []
    
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
    
    private func index(of moviesViewController: MoviesListViewController?) -> Int {
        guard let moviesViewController = moviesViewController,
            let index = moviesViewControllers.index(of: moviesViewController) else {
            return -1
        }
        return index
    }
    
    private func setupSelectedChildController(_ newChildController: MoviesListViewController, animated: Bool) {
        
        let oldChildController = selectedChildController
        selectedChildController = newChildController
        
        addChildViewController(newChildController)
        oldChildController?.willMove(toParentViewController: nil)
        
        let newView = newChildController.view!
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)
        
        newView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8).isActive = true
        newView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        newView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let oldIndex = index(of: oldChildController)
        let newIndex = index(of: newChildController)
        let directionSign: CGFloat = (oldIndex <= newIndex) ? -1 : 1
        
        newView.transform = CGAffineTransform(translationX: -directionSign * view.bounds.width, y: 0)
        let oldView = oldChildController?.view
        
        let oldViewFinalTransform = CGAffineTransform(translationX: directionSign * view.bounds.width, y: 0)
        
        let duration = animated ? 0.5 : 0
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: {
                        [weak newView, weak oldView] in
                        newView?.transform = .identity
                        oldView?.transform = oldViewFinalTransform },
                       completion: {
                        [weak self, weak oldView,
                        weak oldChildController,
                        weak newChildController] _ in
                        oldView?.removeFromSuperview()
                        oldChildController?.removeFromParentViewController()
                        newChildController?.didMove(toParentViewController: self) }
        )
        
    }
    
}
