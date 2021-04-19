//
//  SharerLinkMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 19/04/21.
//

import UIKit
@testable import DesafioNews

class SharerMock: SharerProtocol {
    
    var presentCalled = false
    var content: Any?
    var viewController: UIViewController?
    
    func share(_ content: Any, on viewController: UIViewController) {
        self.presentCalled = true
        self.content = content
        self.viewController = viewController
    }
    
}
