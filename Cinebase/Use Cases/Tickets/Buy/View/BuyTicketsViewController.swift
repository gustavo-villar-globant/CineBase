//
//  BuyTicketsViewController.swift
//  Cinebase
//
//  Created by Gustavo Villar on 4/19/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

protocol BuyTicketsView: class {
    func setDescription(_ description: String)
}

class BuyTicketsViewController: UIViewController, BuyTicketsView {
    
    var presenter: BuyTicketsPresenter?
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tickets"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
    }
    
    func cancel(_ sender: AnyObject) {
        presenter?.onCancelTouched()
    }
    
    @IBAction func scanCardTouched(_ sender: Any) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)!
        cardIOVC.navigationBarStyleForCardIO = .black
        cardIOVC.keepStatusBarStyleForCardIO = true
        cardIOVC.modalPresentationStyle = .formSheet
        present(cardIOVC, animated: true, completion: nil)
    }
    
    func setDescription(_ description: String) {
        label.text = description
    }
    
}

// MARK: CardIO delegate
extension BuyTicketsViewController: CardIOPaymentViewControllerDelegate {

    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            presenter?.onScanningCreditCard(
                withNumber: info.cardNumber,
                expiryMonth: Int(info.expiryMonth),
                expiryYear: Int(info.expiryYear),
                cvv: info.cvv)
        }
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
}
