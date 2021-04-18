//
//  SignupViewControllerSpec.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 18/04/21.
//

import Quick
import Nimble
@testable import DesafioNews

class SignupViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        let sut = SignupViewController()
        
        // MARK: Functions
        
        describe("Functions") {
            
            context("registerButtonAction") {
                sut.registerButtonAction(sender: nil)
                let viewAlpha = sut.view.alpha
                
                it("should disable interaction") {
                    expect(viewAlpha).to(equal(0.5))
                    expect(sut.view.isUserInteractionEnabled).to(beFalse())
                    expect(sut.signupView.spinner.isAnimating).to(beTrue())
                }
            }
        }
        
        // MARK: View Controller Protocol
        
        describe("ViewControllerProtocol") {
            let sut = SignupViewController()
            
            context("additionalSetup") {
                sut.additionalSetup()
                
                it("should have the title") {
                    expect(sut.title).to(equal("Sign Up"))
                }
                
                it("should correct presenters") {
                    expect(sut.messagePresenter).to(beAKindOf(MessagePresenter.self))
                }
            }
            
            context("delegateSetup") {
                sut.delegateSetup()
                let nameTextFieldDelegate = sut.signupView.signupInformationContainer.nameTextField.delegate
                let emailTextFieldDelegate = sut.signupView.signupInformationContainer.emailTextField.delegate
                let passwordTextFieldDelegate = sut.signupView.signupInformationContainer.passwordTextField.delegate
                let signupViewModelDelegate = sut.signupViewModel.delegate
                
                it("should correct delegates") {
                    expect(nameTextFieldDelegate).to(beAKindOf(SignupViewController.self))
                    expect(emailTextFieldDelegate).to(beAKindOf(SignupViewController.self))
                    expect(passwordTextFieldDelegate).to(beAKindOf(SignupViewController.self))
                    expect(signupViewModelDelegate).to(beAKindOf(SignupViewController.self))
                }
            }
        }
        
        // MARK: View Model Delegate
        
        describe("ViewModelDelegate") {
            context("requestSucess") {
                let sut = SignupViewController()
                let messagePresenter = MessagePresenterMock()
                sut.messagePresenter = messagePresenter
                sut.requestSucess()
                
                it("should displayed message sucess") {
                    expect(messagePresenter.presentCalled).toEventually(beTrue())
                    expect(messagePresenter.message).toEventually(equal("Cadastro realizado!"))
                    expect(messagePresenter.viewController == sut).toEventually(beTrue())
                }
                
                it("should stop animating spinner") {
                    expect(sut.signupView.spinner.isAnimating).toEventually(beFalse())
                }
            }
            
            context("requestError") {
                let sut = SignupViewController()
                let messagePresenter = MessagePresenterMock()
                sut.messagePresenter = messagePresenter
                sut.requestError(errorMessage: "Error message")
                
                it("should displayed message error") {
                    expect(messagePresenter.presentCalled).toEventually(beTrue())
                    expect(messagePresenter.message).toEventually(equal("Error message"))
                    expect(messagePresenter.viewController == sut).toEventually(beTrue())
                }
                
                it("should enable user interaction") {
                    expect(sut.signupView.isUserInteractionEnabled).toEventually(beTrue())
                    expect(sut.signupView.alpha).toEventually(equal(1))
                    expect(sut.signupView.spinner.isAnimating).toEventually(beFalse())
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
                    expect(isHidden).to(be(true))
                }
            }
            
            context("textField_shouldChangeCharactersIn") {
                let textString = "123456789012345678901234567890123456"
                let limit = sut.textField(textField, shouldChangeCharactersIn: NSRange(), replacementString: textString)
                
                it("should limit for 35 chars") {
                    expect(limit).to(equal(false))
                }
            }
        }
    }

}
