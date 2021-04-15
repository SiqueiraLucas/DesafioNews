//
//  NewsViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 14/04/21.
//

import Foundation

class NewsViewModel {
    
    //MARK: - Instances
    
    private var newsModel: NewsModel
    
    var networkRequest: NetworkRequestGetProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    var countItems : Int {
        return newsModel.data.count
    }
    
    //MARK: Initializer
    
    init (model: NewsModel){
        self.newsModel = model
        self.networkRequest = NetworkRequestGet()
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
    
    // MARK: Request
    
    func request(endpoint: String, components: [URLQueryItem]?){
        networkRequest?.get(resource: NewsModel.self, endpoint: endpoint, components: components, completionHandler: { [weak self] (result) in
            switch result {
                case .success(let data):
                    self?.newsModel = data
                    self?.delegate?.requestSucess()
                case .failure(let error):
                    print(error)
                    self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
            }
        })
    }
}
