//
//  SignupInformationContainer.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import UIKit

class SignupInformationContainer: UIStackView {

    // MARK: Instance Properties
    
    lazy var nameTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.placeholder = "Name"
        view.borderStyle = .roundedRect
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.placeholder = "Password"
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

extension SignupInformationContainer: ViewCodeProtocol {
    func setupConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addViewHierarchy() {
        addArrangedSubview(nameTextField)
        addArrangedSubview(emailTextField)
        addArrangedSubview(passwordTextField)
    }

    func configureConstraints() {
        axis = .vertical
        distribution = .fillEqually
        spacing = 10
    }
}
