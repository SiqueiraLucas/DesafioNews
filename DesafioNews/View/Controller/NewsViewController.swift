//
//  NewsViewController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import UIKit

class NewsViewController: UIViewController {

    // MARK: Instances

    let signinView = SigninView(frame: UIScreen.main.bounds)

    // MARK: Life Cycle

    override func loadView() {
        self.view = signinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationControllerSetup()
    }
    
    // MARK: Functions
    
    @objc func loginButtonAction(sender: UIButton!) {
        
    }

}

// MARK: Protocol Setup

extension NewsViewController: ViewControllerProtocol{
    
    func additionalSetup() {
        self.title = "News"
    }
    
    func delegateSetup() {
        
    }
    
    func targetsSetup() {
        signinView.loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    func closureSetup()  {
        
    }
    
    func getContentSetup(){
        
    }
    
    func navigationControllerSetup(){
    }
}
