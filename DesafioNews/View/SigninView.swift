//
//  SigninView.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import UIKit

class SigninView: UIView {

    // MARK: Instance Properties

    var lloom = UILabel()

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
        backgroundColor = .red
    }

    func addViewHierarchy() {
    }

    func configureConstraints() {
    }
}
