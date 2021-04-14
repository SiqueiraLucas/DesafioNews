//
//  SigninInformationContainer.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import UIKit

class SigninInformationContainer: UIStackView {

    // MARK: Instance Properties
    
    lazy var emailTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "Email"
        view.borderStyle = .roundedRect
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "Senha"
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Init

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Extension

extension SigninInformationContainer: ViewCodeProtocol {
    func setupConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addViewHierarchy() {
        addArrangedSubview(emailTextField)
        addArrangedSubview(passwordTextField)
    }

    func configureConstraints() {
        axis = .vertical
        distribution = .fillEqually
        spacing = 10
    }
}
