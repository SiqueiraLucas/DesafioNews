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
    
    // MARK: Request
    
    func request(endpoint: String){
        networkRequest?.get(resource: NewsModel.self, endpoint: endpoint, completionHandler: { [weak self] (result) in
            switch result {
                case .success(let data):
                    self?.feedModel = data
                    self?.delegate?.requestSucess()
                case .failure(let error):
                    print(error)
                    self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
            }
        })
    }
}
