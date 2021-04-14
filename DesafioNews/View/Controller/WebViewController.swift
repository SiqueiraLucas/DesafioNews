//
//  WebViewController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 13/04/21.
//

import WebKit

class WebViewController: UIViewController {
    private let webView = WKWebView()
    private let urlString: String
    private let newsTitle: String
    private let shareButton = UIBarButtonItem(systemItem: .action)
    private let favoriteButton = UIBarButtonItem()
    private let fixedSpace = UIBarButtonItem(systemItem: .fixedSpace)
    
    init(urlString: String, newsTitle: String) {
        self.urlString = urlString
        self.newsTitle = newsTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        setup()
    }
    
    @objc func favoriteButtonAction(sender: UIButton) {
        print("opa favoritou")
    }
    
    @objc func shareButtonAction(sender: UIButton) {
        print("opa")
    }
}

extension WebViewController: ViewControllerProtocol {
    func closureSetup() {
        
    }
    
    func delegateSetup() {
    }
    
    func getContentSetup() {
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func targetsSetup() {
        shareButton.target = self
        shareButton.action = #selector(shareButtonAction)
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonAction)
    }
    
    func additionalSetup() {
        favoriteButton.image = UIImage(systemName: "heart")
        fixedSpace.width = UIScreen.main.bounds.width/3.3
        navigationItem.rightBarButtonItems = [shareButton, fixedSpace, favoriteButton]
    }
    
    
}
