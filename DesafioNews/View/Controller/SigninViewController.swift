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
    var signinViewModel = SigninViewModel(apiRequest: APIRequestPost())
    var messagePresenter: MessagePresenterProtocol?

    // MARK: Life Cycle

    override func loadView() {
        self.view = signinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationControllerSetup()
        
    }
    
    // MARK: Functions
    
    @objc func loginButtonAction(sender: UIButton) {
        signinView.spinner.startAnimating()
        signinView.isUserInteractionEnabled = false
        signinView.alpha = 0.5
        signinViewModel.sendValue(from: signinView.signinInformationContainer.emailTextField.text, passwordTextField: signinView.signinInformationContainer.passwordTextField.text)
    }
    
    func showViewController(viewController: UIViewController){
//        guard let sceneDelegate = UIApplication.shared.connectedScenes
//                .first?.delegate as? SceneDelegate else {return}
//        let navigation = UINavigationController(rootViewController: viewController)
//        sceneDelegate.window?.rootViewController = navigation
        
//        viewController.modalPresentationStyle = .fullScreen
//        self.navigationController?.present(viewController, animated: true, completion: {
//            self.removeFromParent()
//        })
        
        self.navigationController?.setViewControllers([viewController], animated: true)
        self.removeFromParent()
    }

}

// MARK: ViewControllerProtocol

extension SigninViewController: ViewControllerProtocol{
    
    func additionalSetup() {
        messagePresenter = MessagePresenter()
    }
    
    func delegateSetup() {
        signinView.signinInformationContainer.emailTextField.delegate = self
        signinView.signinInformationContainer.passwordTextField.delegate = self
        signinViewModel.delegate = self
    }
    
    func targetsSetup() {
        signinView.loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    func closureSetup()  {
        
    }
    
    func getContentSetup(){
        
    }
    
    func navigationControllerSetup(){
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK: - UITextFieldDelegate

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

// MARK: - ViewModelDelegate

extension SigninViewController: ViewModelDelegate{
    func requestSucess() {
        DispatchQueue.main.async {
            self.signinView.spinner.stopAnimating()
            self.showViewController(viewController: NewsViewController())
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
    
    func getInformationBack() {
    }
    
}
