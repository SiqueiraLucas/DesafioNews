//
//  ViewCode.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import Foundation

protocol ViewCode {
    func setupView()
    func setupConfiguration()
    func addViewHierarchy()
    func configureConstraints()
}

extension ViewCode {
    func setupView() {
        setupConfiguration()
        addViewHierarchy()
        configureConstraints()
    }
}
