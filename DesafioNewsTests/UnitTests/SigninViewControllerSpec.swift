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
        
        let sut = SigninViewController()
        
        // MARK: Functions
        
        describe("Functions") {
            
            context("loginButtonAction") {
                it("should disable interaction") {
                    sut.loginButtonAction(sender: nil)
                    let viewAlpha = sut.view.alpha
                    
                    expect(viewAlpha).to(equal(0.5))
                    expect(sut.view.isUserInteractionEnabled).to(beFalse())
                    expect(sut.signinView.spinner.isAnimating).to(beTrue())
                }
            }
            
            context("registerButtonAction") {
                let controllerPresenter = ViewControllerPresenterMock()
                sut.viewControllerPresenter = controllerPresenter
                sut.registerButtonAction(sender: nil)
                
                it("should show SignupViewController") {
                    expect(controllerPresenter.presentCalled).to(beTrue())
                    expect(controllerPresenter.fromViewController).to(equal(sut))
                    expect(controllerPresenter.toViewController).to(beAKindOf(SignupViewController.self))
                }
            }
        }
        
        // MARK: View Controller Protocol
        
        describe("ViewControllerProtocol") {
            let sut = SigninViewController()
            
            context("additionalSetup") {
                sut.additionalSetup()
                
                it("should have the title") {
                    expect(sut.title).to(equal("Login"))
                }
                
                it("should correct presenters") {
                    expect(sut.messagePresenter).to(beAKindOf(MessagePresenter.self))
                    expect(sut.viewControllerPresenter).to(beAKindOf(ViewControllerPresenter.self))
                }
            }
            
            context("delegateSetup") {
                sut.delegateSetup()
                let emailTextFieldDelegate = sut.signinView.signinInformationContainer.emailTextField.delegate
                let passwordTextFieldDelegate = sut.signinView.signinInformationContainer.passwordTextField.delegate
                let signinViewModelDelegate = sut.signinViewModel.delegate
                
                it("should correct delegates") {
                    expect(emailTextFieldDelegate).to(beAKindOf(SigninViewController.self))
                    expect(passwordTextFieldDelegate).to(beAKindOf(SigninViewController.self))
                    expect(signinViewModelDelegate).to(beAKindOf(SigninViewController.self))
                }
            }
        }
        
        // MARK: View Model Delegate
        
        describe("ViewModelDelegate") {
            context("requestSucess") {
                let controllerPresenter = ViewControllerPresenterMock()
                sut.viewControllerPresenter = controllerPresenter
                sut.requestSucess()
                
                it("should go to NewsTabBarController") {
                    expect(controllerPresenter.presentCalled).toEventually(beTrue())
                    expect(controllerPresenter.fromViewController).toEventually(beNil())
                    expect(controllerPresenter.toViewController).toEventually(beAKindOf(NewsTabBarController.self))
                }
            }
            
            context("requestError") {
                let sut = SigninViewController()
                let messagePresenter = MessagePresenterMock()
                sut.messagePresenter = messagePresenter
                sut.requestError(errorMessage: "Error message")

                it("should displayed message error") {
                    expect(messagePresenter.presentCalled).toEventually(beTrue())
                    expect(messagePresenter.message).toEventually(equal("Error message"))
                    expect(messagePresenter.viewController == sut).toEventually(beTrue())
                }
                
                it("should enable user interaction") {
                    expect(sut.signinView.isUserInteractionEnabled).toEventually(beTrue())
                    expect(sut.signinView.alpha).toEventually(equal(1))
                    expect(sut.signinView.spinner.isAnimating).toEventually(beFalse())
                }
            }
        }
        
        // MARK: Text Field Delegate
        
        describe("TextFieldDelegate") {
            let textField = UITextField()
            textField.delegate = sut
            textField.becomeFirstResponder()
            
            context("textFieldShouldReturn") {
                let isHidden = sut.textFieldShouldReturn(textField)

                it("should hide text field") {
                    expect(isHidden).to(beTrue())
                }
            }
            
            context("textField_shouldChangeCharactersIn") {
                let textString = "123456789012345678901234567890123456"
                let limit = sut.textField(textField, shouldChangeCharactersIn: NSRange(), replacementString: textString)
                
                it("should limit for 35 chars") {
                    expect(limit).to(beFalse())
                }
            }
        }
    }

}
