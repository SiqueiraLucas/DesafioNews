//
//  WebViewController.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 13/04/21.
//

import WebKit

class WebViewController: UIViewController {
    let webView = WKWebView()
    let urlString: String
    let newsTitle: String
    var isFavorite = false
    let shareButton = UIBarButtonItem(systemItem: .action)
    let favoriteButton = UIBarButtonItem()
    let fixedSpace = UIBarButtonItem(systemItem: .fixedSpace)
    var sharer: SharerProtocol?
    
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
        if isFavorite{
            UserDefaults.standard.removeObject(forKey: newsTitle)
            favoriteButton.image = UIImage(systemName: "heart")
        }else{
            UserDefaults.standard.setValue(true, forKey: newsTitle)
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
        isFavorite = !isFavorite
    }
    
    @objc func shareButtonAction(sender: UIButton) {
        sharer?.share(urlString, on: self)
    }
}

extension WebViewController: ViewControllerProtocol {
    
    func getContentSetup() {
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
        isFavorite = UserDefaults.standard.bool(forKey: newsTitle)
        if isFavorite{
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }else{
            favoriteButton.image = UIImage(systemName: "heart")
        }
    }
    
    func targetsSetup() {
        shareButton.target = self
        shareButton.action = #selector(shareButtonAction)
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonAction)
    }
    
    func additionalSetup() {
        sharer = SharerLink()
        fixedSpace.width = UIScreen.main.bounds.width/3.3
        navigationItem.rightBarButtonItems = [shareButton, fixedSpace, favoriteButton]
    }
    
    func delegateSetup() {}
    
}
