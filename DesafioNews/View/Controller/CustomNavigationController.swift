//
//  CustomNavigationController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 12/04/21.
//

import UIKit

class CustomNavigationController: UINavigationController{
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
