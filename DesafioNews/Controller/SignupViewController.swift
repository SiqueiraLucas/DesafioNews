//
//  SignupViewController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: Instances

    let signupView = SignupView(frame: UIScreen.main.bounds)
    var signupViewModel = SignupViewModel()
    var messagePresenter: MessagePresenterProtocol?

    // MARK: Life Cycle

    override func loadView() {
        self.view = signupView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Functions
    
    @objc func registerButtonAction(sender: UIButton?) {
        signupView.spinner.startAnimating()
        signupView.isUserInteractionEnabled = false
        signupView.alpha = 0.5
        signupViewModel.sendValue(nameTextField: signupView.signupInformationContainer.nameTextField.text, emailTextField: signupView.signupInformationContainer.emailTextField.text, passwordTextField: signupView.signupInformationContainer.passwordTextField.text)
    }

}

// MARK: View Controller Protocol

extension SignupViewController: ViewControllerProtocol{
    
    func additionalSetup() {
        self.title = "Sign Up"
        messagePresenter = MessagePresenter()
    }
    
    func delegateSetup() {
        signupView.signupInformationContainer.nameTextField.delegate = self
        signupView.signupInformationContainer.emailTextField.delegate = self
        signupView.signupInformationContainer.passwordTextField.delegate = self
        signupViewModel.delegate = self
    }
    
    func targetsSetup() {
        signupView.registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
    }
    
    func getContentSetup(){}
    
}

// MARK: - View Model Delegate

extension SignupViewController: ViewModelDelegate{
    func requestSucess() {
        DispatchQueue.main.async {
            self.signupView.spinner.stopAnimating()
            self.messagePresenter?.presentMessage("Cadastro realizado!", on: self)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func requestError(errorMessage: String) {
        DispatchQueue.main.async {
            self.signupView.isUserInteractionEnabled = true
            self.signupView.alpha = 1
            self.signupView.spinner.stopAnimating()
            self.messagePresenter?.presentMessage(errorMessage, on: self)
        }
    }
    
}

// MARK: - Text Field Delegate

extension SignupViewController: UITextFieldDelegate {
    
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
