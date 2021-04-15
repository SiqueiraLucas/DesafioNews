//
//  SigninViewControllerSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class SigninViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("SigninViewController") {
            
            let navigation = CustomNavigationController(rootViewController: SigninViewController())
            guard let sut = navigation.viewControllers[0] as? SigninViewController else {return}
            
            context("Load View") {
                _ = sut.view
                
                it("should load 'messagePresenter'") {
                    expect(sut.messagePresenter != nil).to(beTrue())
                }
            }
            
            context("displayAlert") {
                let messagePresenter = MessagePresenterMock()
                sut.messagePresenter = messagePresenter
                sut.displayAlert(message: "Message")

                it("should displayed message") {
                    expect(messagePresenter.presentCalled).to(be(true))
                    expect(messagePresenter.message).to(equal("Message"))
                    expect(messagePresenter.viewController == sut).to(be(true))
                }
            }
            
            context("loginButtonAction") {
                sut.loginButtonAction(sender: nil)
                let viewAlpha = sut.view.alpha

                it("should decrease alpha") {
                    expect(viewAlpha).to(equal(0.5))
                }
                
                it("should disable interaction") {
                    expect(sut.view.isUserInteractionEnabled).to(be(false))
                }
            }
            
            context("registerButtonAction") {
                sut.registerButtonAction(sender: nil)
                
                it("should show signup view") {
                    expect(sut.navigationController != nil).to(be(true))
                }
            }
        }
    }

}
