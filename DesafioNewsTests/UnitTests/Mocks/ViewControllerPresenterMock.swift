//
//  ViewControllerPresenterMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 16/04/21.
//

import UIKit
@testable import DesafioNews

class ViewControllerPresenterMock: ViewControllerPresenterProtocol {
    
    var presentCalled = false
    var fromViewController: UIViewController?
    var toViewController: UIViewController?
    
    func present(_ from: UIViewController, to viewController: UIViewController, newTree: Bool) {
        self.presentCalled = true
        self.fromViewController = from
        self.toViewController = viewController
        if newTree{
            self.fromViewController = nil
        }
    }
    
}
