//
//  TabBarController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit

class NewsTabBarController: UITabBarController {
    
    // MARK: Init
    
    init(initialTabBar: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.setup(initialTabBar: initialTabBar)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setup(initialTabBar: UIViewController){
        super.viewWillAppear(true)
        tabBar.tintColor = .systemOrange
        tabBar.isTranslucent = true
        let controllers = [initialTabBar]
        self.viewControllers = controllers.map { CustomNavigationController(rootViewController: $0)}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: Delegate

extension NewsTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
}
