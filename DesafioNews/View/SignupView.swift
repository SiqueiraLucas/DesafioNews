//
//  SignupView.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import UIKit

class SignupView: UIView {

    // MARK: Instance Properties
    
    let signupInformationContainer = SignupInformationContainer()

    lazy var registerButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Sign Up", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemOrange
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

extension SignupView: ViewCodeProtocol {
    func setupConfiguration() {
        backgroundColor = .white
    }

    func addViewHierarchy() {
        addSubview(signupInformationContainer)
        addSubview(registerButton)
        addSubview(spinner)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            signupInformationContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            signupInformationContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signupInformationContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            signupInformationContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            
            registerButton.topAnchor.constraint(equalTo: signupInformationContainer.bottomAnchor, constant: 30),
            registerButton.widthAnchor.constraint(equalTo: signupInformationContainer.widthAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.centerXAnchor.constraint(equalTo: signupInformationContainer.centerXAnchor),
            
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
