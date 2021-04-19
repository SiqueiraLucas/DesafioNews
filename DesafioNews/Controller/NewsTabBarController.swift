//
//  TabBarController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit

class NewsTabBarController: UITabBarController {
    
    // MARK: Instances
    
    lazy var initialTabBar: NewsViewController = {
        let initialTabBar = NewsViewController()
        let title = "News"
        let defaultImage = UIImage(systemName: "newspaper")
        let selectedImage = UIImage(systemName: "newspaper.fill")
        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        initialTabBar.tabBarItem = tabBarItem
        return initialTabBar
    }()
    
    // MARK: Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setup(){
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
