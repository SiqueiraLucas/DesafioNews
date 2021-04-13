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
    let spotlightViewModel = SpotlightViewModel(model: NewsModel(), networkRequest: NetworkRequest())
    let feedViewModel = FeedViewModel(model: NewsModel(), networkRequest: NetworkRequest())
    private var messagePresenter: MessagePresenterProtocol?

    // MARK: Life Cycle

    override func loadView() {
        self.view = newsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Functions
    
    @objc func loginButtonAction(sender: UIButton!) {
        
    }

}

// MARK: Protocol Setup

extension NewsViewController: ViewControllerProtocol{
    
    func additionalSetup() {
        self.title = "News"
        messagePresenter = MessagePresenter()
    }
    
    func delegateSetup() {
        newsView.collectionView.delegate = self
        newsView.collectionView.dataSource = self
        spotlightViewModel.delegate = self
        feedViewModel.delegate = self
        
    }
    
    func targetsSetup() {
    }
    
    func closureSetup()  {
    }
    
    func getContentSetup(){
        let endpoint = "https://mesa-news-api.herokuapp.com/v1/client/news/highlights"
        let endpoint2 = "https://mesa-news-api.herokuapp.com/v1/client/news?current_page=&per_page=&published_at="
        spotlightViewModel.request(endpoint: endpoint)
        feedViewModel.request(endpoint: endpoint2)
    }
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
    
    func getInformationBack() {
    }
    
}
