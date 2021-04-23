//
//  FeedViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 12/04/21.
//

import Foundation

class FeedViewModel {
    
    //MARK: - Instances
    
    private var newsModel: NewsModel
    private var apiRequestKey: String
    private var newCurrentPage = 0
    var endpoint = "https://mesa-news-api.herokuapp.com/v1/client/news?current_page=&per_page=&published_at="
    var networkRequest: NetworkRequestProtocol?
    var countItems : Int {
        return newsModel.data.count
    }
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init (model: NewsModel, apiRequestKey: String){
        self.newsModel = model
        self.apiRequestKey = apiRequestKey
        self.networkRequest = NetworkRequest()
    }
    
    //MARK: Functions
    
    func returnTitle(index: Int) -> String?{
        return newsModel.data[index].title
    }
    
    func returnDescription(index: Int) -> String?{
        return newsModel.data[index].description
    }
    
    func returnDate(index: Int) -> String?{
        let date = newsModel.data[index].published_at
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let dateFromString : Date = dateFormatter.date(from: date) else {return "10/10/2020"}
        dateFormatter.dateFormat = "dd/MM/yyy"
        let newDate = dateFormatter.string(from: dateFromString)
        return newDate
    }
    
    func returnFavoriteIsHidden(index: Int) -> Bool {
        let newsTitle = newsModel.data[index].title
        return !UserDefaults.standard.bool(forKey: newsTitle)
    }
    
    func returnUrl(index: Int) -> String? {
        return newsModel.data[index].url
    }
    
    func returnImageUrl(index: Int) -> String? {
        return newsModel.data[index].image_url
    }
    
    private func returnCurrentPage() ->String {
        newCurrentPage += 1
        return newCurrentPage.description
    }
    
    func returnUrlComponents() -> [String: Any]{
        return [
            "current_page" : returnCurrentPage(),
            "per_page" : "10",
            "published_at" : ""
        ]
    }
    
    // MARK: Request
    
    func request(components: [String: Any]?){
        networkRequest?.request(resource: NewsModel.self, method: .get, endpoint: endpoint, components: components, key: apiRequestKey, completionHandler: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
                case .success(let data):
                    self.newsModel.data.append(contentsOf: data.data)
                    self.delegate?.requestSucess()
                case .failure(let error):
                    print(error)
            }
        })
    }
}
