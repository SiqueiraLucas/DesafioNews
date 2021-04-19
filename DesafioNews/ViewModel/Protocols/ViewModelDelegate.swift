//
//  ViewModelDelegate.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

protocol ViewModelDelegate: class {
    func requestSucess()
    func requestError(errorMessage: String)
}
