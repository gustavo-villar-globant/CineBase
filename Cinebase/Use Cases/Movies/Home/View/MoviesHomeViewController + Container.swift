//
//  MoviesHomeViewController + Container.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

extension MoviesHomeViewController {
    
    // MARK: Container controller methods
    
    func index(of moviesViewController: MoviesListViewController?) -> Int {
        guard let moviesViewController = moviesViewController,
            let index = moviesViewControllers.index(of: moviesViewController) else {
                return -1
        }
        return index
    }
    
    func directionFactor(from oldChildController: MoviesListViewController?, to newChildController: MoviesListViewController) -> CGFloat {
        let oldIndex = index(of: oldChildController)
        let newIndex = index(of: newChildController)
        return (oldIndex <= newIndex) ? -1 : 1
    }
    
    func beginChildTransition(to newChildController: MoviesListViewController) {
        
        guard newChildController != selectedChildController else { return }
        
        let oldChildController = selectedChildController
        transitioningChildController = newChildController
        
        addChildViewController(newChildController)
        oldChildController?.willMove(toParentViewController: nil)
        
        let newView = newChildController.view!
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)
        
        newView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        newView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        newView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        updateChildTransition(fractionCompleted: 0)
        
    }
    
    func updateChildTransition(fractionCompleted: CGFloat) {
        
        let boundedFractionCompleted = min(fractionCompleted, 1)
        
        guard let newChildController = transitioningChildController else { return }
        let newView = newChildController.view!
        let oldChildController = selectedChildController
        let oldView = oldChildController?.view
        
        let directionFactor = self.directionFactor(from: oldChildController, to: newChildController)
        
        newView.transform = CGAffineTransform(translationX: (boundedFractionCompleted - 1) * directionFactor * view.bounds.width, y: 0)
        oldView?.transform = CGAffineTransform(translationX: (boundedFractionCompleted) * directionFactor * view.bounds.width, y: 0)
        
    }
    
    func completeChildTransition(withDuration duration: TimeInterval, initialVelocity: CGFloat) {
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: initialVelocity,
            options: [],
            animations: { [weak self] in
                self?.updateChildTransition(fractionCompleted: 1)
            }, completion: { [weak self] _ in
                self?.endChildTransition()
        })
    }
    
    func revertChildTransition(withDuration duration: TimeInterval, initialVelocity: CGFloat) {
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: initialVelocity,
            options: [],
            animations: { [weak self] in
                self?.updateChildTransition(fractionCompleted: 0)
            }, completion: { [weak self] _ in
                self?.cancelChildTransition()
        })
        
    }
    
    func endChildTransition() {
        
        guard let newChildController = transitioningChildController else { return }
        let oldChildController = selectedChildController
        let oldView = oldChildController?.view
        
        updateChildTransition(fractionCompleted: 1)
        
        oldView?.removeFromSuperview()
        oldChildController?.removeFromParentViewController()
        newChildController.didMove(toParentViewController: self)
        
        selectedChildController = newChildController
        transitioningChildController = nil
        
    }
    
    func cancelChildTransition() {
        
        guard let newChildController = transitioningChildController else { return }
        let newView = newChildController.view!
        let oldChildController = selectedChildController
        
        newChildController.willMove(toParentViewController: nil)
        oldChildController?.willMove(toParentViewController: self)
        updateChildTransition(fractionCompleted: 0)
        newView.removeFromSuperview()
        newChildController.removeFromParentViewController()
        oldChildController?.didMove(toParentViewController: self)
        
        transitioningChildController = nil
        
    }
    
    func setupSelectedChildController(_ newChildController: MoviesListViewController, animated: Bool) {
        
        beginChildTransition(to: newChildController)
        
        let duration = animated ? 0.5 : 0
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [],
            animations: { [weak self] in
                self?.updateChildTransition(fractionCompleted: 1)
            }, completion: { [weak self, newChildController] _ in
                guard self?.transitioningChildController == newChildController else { return }
                self?.endChildTransition()
            }
        )
        
    }
    
}
