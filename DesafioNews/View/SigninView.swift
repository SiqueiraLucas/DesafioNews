//
//  SigninView.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import UIKit

class SigninView: UIView {

    // MARK: Instance Properties
    
    let signinInformationContainer = SigninInformationContainer()

    lazy var loginButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Login", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var registerButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Create Account?", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Init

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Extension

extension SigninView: ViewCodeProtocol {
    func setupConfiguration() {
        backgroundColor = .white
    }

    func addViewHierarchy() {
        addSubview(signinInformationContainer)
        addSubview(loginButton)
        addSubview(registerButton)
        addSubview(spinner)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            signinInformationContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            signinInformationContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signinInformationContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            signinInformationContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            
            loginButton.topAnchor.constraint(equalTo: signinInformationContainer.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalTo: signinInformationContainer.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: signinInformationContainer.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
            registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            registerButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
