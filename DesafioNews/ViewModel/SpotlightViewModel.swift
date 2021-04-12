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
    
    private var images = [UIImage?]()
    
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
        if images.count > index{
            return images[index]
        }else{
            return nil
        }
    }
    
    private func loadImages(){
        images = [UIImage?] (repeating: nil, count: countItems-1)
        for i in 0...countItems-1{
            addImage(index: i)
            if i == countItems-1{
                delegate?.requestSucess()
            }
        }
    }
    
    private func addImage(index: Int){
        guard let url = URL(string: spotlight.data[index].image_url) else {return}
        let data = try? Data(contentsOf: url)
        guard let imageData = data else {return}
        guard let image = UIImage(data: imageData) else {return}
        images[index] = image
        
    }
    
    // MARK: Request
    
    func request(endpoint: String){
        apiRequest?.getRequest(endpoint: endpoint) { [weak self] (result: Result<SpotlightModel, RequestError>) in
            switch result {
                case .success(let data):
                    self?.spotlight = data
                    self?.loadImages()
                case .failure(let error):
                    print(error)
                    self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
            }
        }
    }
}
