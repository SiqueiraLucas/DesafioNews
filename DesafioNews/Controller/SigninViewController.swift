//
//  SigninViewController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import UIKit

class SigninViewController: UIViewController {

    // MARK: Instances

    let signinView = SigninView(frame: UIScreen.main.bounds)
    var signinViewModel = SigninViewModel()
    var messagePresenter: MessagePresenterProtocol?
    var viewControllerPresenter: ViewControllerPresenterProtocol?

    // MARK: Life Cycle

    override func loadView() {
        self.view = signinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Functions
    
    @objc func loginButtonAction(sender: UIButton?) {
        signinView.spinner.startAnimating()
        signinView.isUserInteractionEnabled = false
        signinView.alpha = 0.5
        signinViewModel.sendValue(emailTextField: signinView.signinInformationContainer.emailTextField.text, passwordTextField: signinView.signinInformationContainer.passwordTextField.text)
    }
    
    @objc func registerButtonAction(sender: UIButton?) {
        viewControllerPresenter?.present(self, to: SignupViewController(), newTree: false)
    }

}

// MARK: View Controller Protocol

extension SigninViewController: ViewControllerProtocol{
    
    func additionalSetup() {
        self.title = "Login"
        messagePresenter = MessagePresenter()
        viewControllerPresenter = ViewControllerPresenter()
    }
    
    func delegateSetup() {
        signinView.signinInformationContainer.emailTextField.delegate = self
        signinView.signinInformationContainer.passwordTextField.delegate = self
        signinViewModel.delegate = self
    }
    
    func targetsSetup() {
        signinView.loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        signinView.registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
    }
    
    func getContentSetup(){}
    
}

// MARK: - View Model Delegate

extension SigninViewController: ViewModelDelegate{
    func requestSucess() {
        DispatchQueue.main.async {
            self.signinView.spinner.stopAnimating()
            self.viewControllerPresenter?.present(self, to: NewsTabBarController(initialTabBar: NewsViewController(apiRequestKey: self.signinViewModel.returnApiRequestKey())), newTree: true)
        }
    }
    
    func requestError(errorMessage: String) {
        DispatchQueue.main.async {
            self.signinView.isUserInteractionEnabled = true
            self.signinView.alpha = 1
            self.signinView.spinner.stopAnimating()
            self.messagePresenter?.presentMessage(errorMessage, on: self)
        }
    }
    
}

// MARK: - Text Field Delegate

extension SigninViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newChar = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newChar.count
        
        if string == "\n"{
            textField.resignFirstResponder()
        }
        return numberOfChars <= 35
    }
}
