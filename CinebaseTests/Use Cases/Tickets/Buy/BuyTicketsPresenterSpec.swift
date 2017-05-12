//
//  BuyTicketsPresenterSpec.swift
//  Cinebase
//
//  Created by Gustavo Villar on 5/12/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Quick
import Nimble
@testable import Cinebase

class BuyTicketsPresenterSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("a Buy Tickets Presenter") {
            
            var sut: BuyTicketsPresenter!
            var mockView: MockBuyTicketsView!
            var mockRouter: MockRouter!
            beforeEach {
                mockRouter = MockRouter()
                mockView = MockBuyTicketsView()
                sut = BuyTicketsPresenter(view: mockView)
                sut.dismiss = {
                    mockRouter.isDismissed = true
                }
            }
            
            context("when a credit card is scanned") {
                beforeEach {
                    sut.onScanningCreditCard(
                        withNumber: "1234",
                        expiryMonth: 12,
                        expiryYear: 2020,
                        cvv: "987")
                }
                it("should change the description") {
                    let expectedDescription = "Received card info.\nNumber: 1234\nexpiry: 12/2020\ncvv: 987"
                    expect(mockView.description).to(equal(expectedDescription))
                }
            }
            
            context("when the cancel button is touched") {
                beforeEach {
                    sut.onCancelTouched()
                }
                it("should dismiss") {
                    expect(mockRouter.isDismissed).to(beTrue())
                }
            }
            
        }
    }
    
}

// MARK: Mocks
extension BuyTicketsPresenterSpec {
    
    class MockBuyTicketsView: BuyTicketsView {
        
        private(set) var description: String?
        
        func setDescription(_ description: String) {
            self.description = description
        }
        
    }
    
    class MockRouter {
        var isDismissed = false
    }
    
}
