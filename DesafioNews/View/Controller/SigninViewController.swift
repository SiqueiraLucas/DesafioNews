//
//  SigninViewController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 09/04/21.
//

import UIKit

class SigninViewController: UIViewController {
    
    //MARK: Instances
    
    let signinView = SigninView(frame: UIScreen.main.bounds)
    
    //MARK: Life Cycle
    
    override func loadView() {
        self.view = signinView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

}
