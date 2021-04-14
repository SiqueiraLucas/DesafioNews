//
//  FeedViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 12/04/21.
//

import Foundation

class FeedViewModel {
    
    //MARK: - Instances
    
    private var feedModel: NewsModel
    
    private var newCurrentPage = 0
    
    var networkRequest: NetworkRequestProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    var countItems : Int {
        return feedModel.data.count
    }
    
    //MARK: Initializer
    
    init (model: NewsModel){
        self.feedModel = model
        self.networkRequest = NetworkRequest()
    }
    
    //MARK: Functions
    
    func returnTitle(index: Int) -> String?{
        return feedModel.data[index].title
    }
    
    func returnDescription(index: Int) -> String?{
        return feedModel.data[index].description
    }
    
    func returnDate(index: Int) -> String?{
        let date = feedModel.data[index].published_at
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let dateFromString : Date = dateFormatter.date(from: date) else {return "10/10"}
        dateFormatter.dateFormat = "dd/MM/yyy"
        let newDate = dateFormatter.string(from: dateFromString)
        return newDate
    }
    
    func returnUrl(index: Int) -> String? {
        return feedModel.data[index].url
    }
    
    func returnImageUrl(index: Int) -> String? {
        return feedModel.data[index].image_url
    }
    
    func returnFavoriteIsHidden(index: Int) -> Bool {
        let newsTitle = feedModel.data[index].title
        return !UserDefaults.standard.bool(forKey: newsTitle)
    }
    
    private func returnCurrentPage() ->String {
        newCurrentPage += 1
        return newCurrentPage.description
    }
    
    func returnUrlComponents() -> [URLQueryItem]{
        return [
            URLQueryItem(name: "current_page", value: returnCurrentPage()),
            URLQueryItem(name: "per_page", value: "10"),
            URLQueryItem(name: "published_at", value: ""),
        ]
    }
    
    // MARK: Request
    
    func request(endpoint: String, components: [URLQueryItem]?){
        networkRequest?.get(resource: NewsModel.self, endpoint: endpoint,components: components, completionHandler: { [weak self] (result) in
            switch result {
                case .success(let data):
                    self?.feedModel.data.append(contentsOf: data.data)
                    self?.delegate?.requestSucess()
                case .failure(let error):
                    print(error)
            }
        })
    }
}
