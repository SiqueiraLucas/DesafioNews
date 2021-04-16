//
//  SigninViewControllerSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

import Quick
import Nimble
import XCTest
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
            
            context("displayAlertError") {
                let messagePresenter = MessagePresenterMock()
                sut.messagePresenter = messagePresenter
                sut.messagePresenter?.presentMessage("", on: sut)
                sut.requestError(errorMessage: "Error message")

                it("should displayed message") {
                    expect(messagePresenter.presentCalled).toEventually(be(true))
                    expect(messagePresenter.message).toEventually(equal("Error message"))
                    expect(messagePresenter.viewController == sut).toEventually(be(true))
                }
            }
            
            context("registerButtonAction") {
                let controllerPresenter = ViewControllerPresenterMock()
                sut.viewControllerPresenter = controllerPresenter
                
                it("should show signup view") {
                    expect(sut.navigationController != nil).to(be(true))
                }
            }
            
            context("should show new ViewController") {
                let controllerPresenter = ViewControllerPresenterMock()
                sut.viewControllerPresenter = controllerPresenter

                it("should show SignupViewController") {
                    sut.registerButtonAction(sender: nil)

                    expect(controllerPresenter.presentCalled).to(be(true))
                    expect(controllerPresenter.fromViewController).to(equal(sut))
                    expect(controllerPresenter.toViewController).to(beAKindOf(SignupViewController.self))
                }
                
                it("should show NewsTabBarController") {
                    sut.requestSucess()
                    
                    expect(controllerPresenter.presentCalled).toEventually(beTrue())
                    expect(controllerPresenter.fromViewController).toEventually(beNil())
                    expect(controllerPresenter.toViewController).toEventually(beAKindOf(NewsTabBarController.self))
                }
            }
            
            context("text field") {
                let textField = UITextField()
                textField.delegate = sut
                textField.becomeFirstResponder()

                it("should hide") {
                    let isHidden = sut.textFieldShouldReturn(textField)
                    expect(isHidden).to(be(true))
                }
                
                it("should limit 35") {
                    let textString = "123456789012345678901234567890123456"
                    let limit = sut.textField(textField, shouldChangeCharactersIn: NSRange(), replacementString: textString)
                    expect(limit).to(equal(false))
                }
            }
        }
    }

}
