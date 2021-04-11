//
//  SpotlightViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit

class SpotlightViewModel {
    
    //MARK: - Instances
    
    private var spotlight: SpotlightModel
    
    private var images = [UIImage]()
    
    var apiRequest: APIRequestGetProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    var countItems : Int {
        return spotlight.data.count
    }
    
    //MARK: Initializer
    
    init (model: SpotlightModel, apiRequest: APIRequestGetProtocol){
        self.spotlight = model
        self.apiRequest = apiRequest
    }
    
    //MARK: Functions
    
    func returnTitle(index: Int) -> String?{
        return spotlight.data[index].title
    }
    
    func returnDescription(index: Int) -> String?{
        return spotlight.data[index].description
    }
    
    func returnUrl(index: Int) -> String? {
        return spotlight.data[index].url
    }
    
    func returnImage(index: Int) -> UIImage? {
        guard let url = URL(string: spotlight.data[index].image_url) else {return nil}
        let data = try? Data(contentsOf: url)
        guard let imageData = data else {return nil}
        guard let image = UIImage(data: imageData) else {return nil}
        return image
    }
    
    func request(endpoint: String){
        apiRequest?.getRequest(endpoint: endpoint) { [weak self] (result: Result<SpotlightModel, RequestError>) in
            switch result {
                case .success(let data):
                    self?.spotlight = data
                    self?.delegate?.requestSucess()
                case .failure(let error):
                    print(error)
                    self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
            }
        }
    }
}
