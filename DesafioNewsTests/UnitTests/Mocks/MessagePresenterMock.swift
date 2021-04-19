//
//  MessagePresenterMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

import UIKit
@testable import DesafioNews

class MessagePresenterMock: MessagePresenterProtocol {
    
    var presentCalled = false
    var message: String?
    var viewController: UIViewController?
    
    func presentMessage(_ message: String, on viewController: UIViewController) {
        self.presentCalled = true
        self.message = message
        self.viewController = viewController
    }
    
}
