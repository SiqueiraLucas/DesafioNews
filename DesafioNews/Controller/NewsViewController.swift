//
//  NewsViewController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import UIKit

class NewsViewController: UIViewController {

    // MARK: Instances

    let newsView = NewsView(frame: UIScreen.main.bounds)
    var spotlightViewModel: SpotlightViewModel
    var feedViewModel: FeedViewModel
    var messagePresenter: MessagePresenterProtocol?
    var viewControllerPresenter: ViewControllerPresenterProtocol?
    
    // MARK: Init
    
    init(apiRequestKey: String) {
        spotlightViewModel = SpotlightViewModel(apiRequestKey: apiRequestKey)
        feedViewModel = FeedViewModel(apiRequestKey: apiRequestKey)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func loadView() {
        self.view = newsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newsView.collectionView.reloadData()
    }

}

// MARK: Protocol Setup

extension NewsViewController: ViewControllerProtocol{
    
    func additionalSetup() {
        self.title = "News"
        let defaultImage = UIImage(systemName: "newspaper")
        let selectedImage = UIImage(systemName: "newspaper.fill")
        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        self.tabBarItem = tabBarItem
        messagePresenter = MessagePresenter()
        viewControllerPresenter = ViewControllerPresenter()
    }
    
    func delegateSetup() {
        newsView.collectionView.delegate = self
        newsView.collectionView.dataSource = self
        spotlightViewModel.delegate = self
        feedViewModel.delegate = self
    }
    
    func getContentSetup(){
        spotlightViewModel.request(components: nil)
        feedViewModel.request(components: feedViewModel.returnUrlComponents())
    }
    
    func targetsSetup() {}
    
}

// MARK: - View Model Delegate

extension NewsViewController: ViewModelDelegate{
    func requestSucess() {
        DispatchQueue.main.async {
            self.newsView.collectionView.reloadData()
        }
    }
    
    func requestError(errorMessage: String) {
        DispatchQueue.main.async {
            self.messagePresenter?.presentMessage(errorMessage, on: self)
        }
    }
    
}
