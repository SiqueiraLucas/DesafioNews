//
//  ViewControllerPresenter.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 16/04/21.
//

import UIKit

class ViewControllerPresenter: ViewControllerPresenterProtocol {
    
    func present(_ from: UIViewController, to viewController: UIViewController, newTree: Bool) {
        if newTree{
            viewController.modalPresentationStyle = .fullScreen
            from.present(viewController, animated: true, completion: {
                from.navigationController?.removeFromParent()
                from.removeFromParent()
            })
        }else{
            from.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
