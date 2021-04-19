//
//  ViewControllerPresenterProtocol.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 16/04/21.
//

import UIKit

protocol ViewControllerPresenterProtocol {
    
    func present(_ from: UIViewController, to viewController: UIViewController, newTree: Bool)
    
}
