//
//  ViewCodeProtocol.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import Foundation

protocol ViewCodeProtocol {
    func setupView()
    func setupConfiguration()
    func addViewHierarchy()
    func configureConstraints()
}

extension ViewCodeProtocol {
    func setupView() {
        setupConfiguration()
        addViewHierarchy()
        configureConstraints()
    }
}
