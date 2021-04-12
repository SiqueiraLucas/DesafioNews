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
    let spotlightViewModel = SpotlightViewModel(model: SpotlightModel(), apiRequest: APIRequestGet())
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
        
    }
    
    func targetsSetup() {
    }
    
    func closureSetup()  {
    }
    
    func getContentSetup(){
        spotlightViewModel.request(endpoint: "https://mesa-news-api.herokuapp.com/v1/client/news/highlights")
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
