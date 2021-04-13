//
//  SpotlightViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import Foundation

class SpotlightViewModel {
    
    //MARK: - Instances
    
    private var spotlightModel: NewsModel
    
    var networkRequest: NetworkRequestProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    var countItems : Int {
        return spotlightModel.data.count
    }
    
    //MARK: Initializer
    
    init (model: NewsModel, networkRequest: NetworkRequestProtocol){
        self.spotlightModel = model
        self.networkRequest = networkRequest
    }
    
    //MARK: Functions
    
    func returnTitle(index: Int) -> String?{
        return spotlightModel.data[index].title
    }
    
    func returnDescription(index: Int) -> String?{
        return spotlightModel.data[index].description
    }
    
    func returnUrl(index: Int) -> String? {
        return spotlightModel.data[index].url
    }
    
    func returnUrlImage(index: Int) -> String? {
        return spotlightModel.data[index].image_url
    }
    
    // MARK: Request
    
    func request(endpoint: String){
        networkRequest?.get(resource: NewsModel.self, endpoint: endpoint, completionHandler: { [weak self] (result) in
            switch result {
                case .success(let data):
                    self?.spotlightModel = data
                    self?.delegate?.requestSucess()
                case .failure(let error):
                    print(error)
                    self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
            }
        })
    }
}
