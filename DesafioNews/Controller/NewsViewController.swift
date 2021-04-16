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
    let spotlightViewModel = NewsViewModel(model: NewsModel(), networkRequest: NetworkRequestGet())
    let feedViewModel = FeedViewModel(model: NewsModel(), networkRequest: NetworkRequestGet())
    private var messagePresenter: MessagePresenterProtocol?

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
    
    // MARK: Functions
    
    @objc func favoriteButtonAction(sender: UIButton) {
        
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
    
    func getContentSetup(){
        let endpointSpotlight = "https://mesa-news-api.herokuapp.com/v1/client/news/highlights"
        let endpointFeed = "https://mesa-news-api.herokuapp.com/v1/client/news?current_page=&per_page=&published_at="
        spotlightViewModel.request(endpoint: endpointSpotlight, components: nil)
        feedViewModel.request(endpoint: endpointFeed, components: feedViewModel.returnUrlComponents())
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
