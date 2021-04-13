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
    
    init (model: NewsModel, networkRequest: NetworkRequestProtocol){
        self.feedModel = model
        self.networkRequest = networkRequest
    }
    
    //MARK: Functions
    
    func returnTitle(index: Int) -> String?{
        return feedModel.data[index].title
    }
    
    func returnDescription(index: Int) -> String?{
        return feedModel.data[index].description
    }
    
    func returnUrl(index: Int) -> String? {
        return feedModel.data[index].url
    }
    
    func returnUrlImage(index: Int) -> String? {
        return feedModel.data[index].image_url
    }
    
    func returnCurrentPage() ->Int {
        newCurrentPage += 1
        return newCurrentPage
    }
    
    func returnPerPage() -> Int {
        return 10
    }
    
    // MARK: Request
    
    func request(endpoint: String){
        networkRequest?.get(resource: NewsModel.self, endpoint: endpoint, completionHandler: { [weak self] (result) in
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
