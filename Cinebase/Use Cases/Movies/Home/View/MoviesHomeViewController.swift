//
//  MoviesHomeViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/15/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MoviesHomeViewController: UIViewController {
    
    private var segmentedControl: UISegmentedControl!

    var moviesViewControllers: [MoviesListViewController] = []
    var selectedChildController: MoviesListViewController? {
        didSet {
            let childIndex = index(of: selectedChildController)
            segmentedControl.selectedSegmentIndex = childIndex
        }
    }
    var transitioningChildController: MoviesListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupSwipeRecognizer()
        if let firstViewController = moviesViewControllers.first {
            setupSelectedChildController(firstViewController, animated: false)
        }
    }
    
    // MARK: Segmented control methods
    
    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl()
        for (index, moviesVC) in moviesViewControllers.enumerated() {
            segmentedControl.insertSegment(withTitle: moviesVC.title, at: index, animated: false)
        }
        segmentedControl.tintColor = .white
        segmentedControl.sizeToFit()
        navigationItem.titleView = segmentedControl
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    func segmentedControlValueChanged(_ sender: Any) {
        let selectedChildController = moviesViewControllers[segmentedControl.selectedSegmentIndex]
        setupSelectedChildController(selectedChildController, animated: true)
    }
    
    // MARK: Touch methods
    private func setupSwipeRecognizer() {
        let swipeRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    func handleSwipe(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: view)
        
        switch recognizer.state {
            
        case .changed, .began:
            
            let indexDelta = (translation.x.sign == .plus) ? -1 : 1
            let newIndex = index(of: selectedChildController) + indexDelta
            guard newIndex < moviesViewControllers.count, newIndex >= 0 else { return }
            let newChildController = moviesViewControllers[newIndex]
            
            if newChildController != transitioningChildController {
                cancelChildTransition()
                beginChildTransition(to: newChildController)
            }
            
            let fractionCompleted = abs(translation.x / view.bounds.width)
            updateChildTransition(fractionCompleted: fractionCompleted)
            
        case .ended:
            
            let velocity = recognizer.velocity(in: view)
            let fractionCompleted = abs(translation.x / view.bounds.width)
            
            guard let newChildController = transitioningChildController else { return }
            let directionFactor = self.directionFactor(from: selectedChildController, to: newChildController)
            
            if (abs(velocity.x) > 50 && velocity.x.sign == directionFactor.sign) || fractionCompleted > 0.5 {
                // Complete transition
                let velocityFactor: CGFloat = (translation.x.sign == .plus) ? 1 : -1
                let springVelocity = velocity.x * velocityFactor / (view.bounds.width - abs(translation.x))
                let duration = TimeInterval(1 - fractionCompleted) * 0.5 + 0.1 // 0.5s is the duration for the non-interactive transition
                completeChildTransition(withDuration: duration, initialVelocity: springVelocity)
                
            } else {
                // Revert transition
                let velocityFactor: CGFloat = (translation.x.sign == .plus) ? -1 : 1
                let springVelocity = velocity.x * velocityFactor / abs(translation.x)
                let duration = TimeInterval(fractionCompleted) * 0.5 + 0.1 // 0.5s is the duration for the non-interactive transition
                revertChildTransition(withDuration: duration, initialVelocity: springVelocity)
            }
            
        case .cancelled:
            updateChildTransition(fractionCompleted: 0)
            cancelChildTransition()
            
        default:
            break
        }
    }
    
     
}
