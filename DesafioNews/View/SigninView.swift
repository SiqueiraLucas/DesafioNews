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
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "LOGIN"
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

extension SigninView: ViewCode {
    func setupConfiguration() {
        backgroundColor = .white
    }

    func addViewHierarchy() {
        addSubview(title)
        addSubview(signinInformationContainer)
        addSubview(loginButton)
        addSubview(registerButton)
        addSubview(spinner)
    }

    func configureConstraints() {
        signinInformationContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
        signinInformationContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        signinInformationContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        signinInformationContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        
        title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        title.leadingAnchor.constraint(equalTo: signinInformationContainer.leadingAnchor).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: signinInformationContainer.bottomAnchor, constant: 30).isActive = true
        loginButton.widthAnchor.constraint(equalTo: signinInformationContainer.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: signinInformationContainer.centerXAnchor).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        registerButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
