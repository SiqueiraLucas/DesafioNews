//
//  FeedViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 12/04/21.
//

import UIKit

class FeedViewModel {
    
    //MARK: - Instances
    
    private var feedModel: NewsModel
    
    private var images = [UIImage?]()
    
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
    
    func returnImage(index: Int) -> UIImage? {
//        if images.count > index{
//            return images[index]
//        }else{
//            return nil
//        }
        guard let url = URL(string: feedModel.data[index].image_url) else {return nil}
        let data = try? Data(contentsOf: url)
        guard let imageData = data else {return nil}
        guard let image = UIImage(data: imageData) else {return nil}
        return image
    }
    
    private func loadImages(){
        images = [UIImage?] (repeating: nil, count: countItems-1)
        for i in 0...images.count-1{
            addImage(index: i)
            if i == countItems-1{
                delegate?.requestSucess()
            }
        }
    }
    
    private func addImage(index: Int){
        guard let url = URL(string: feedModel.data[index].image_url) else {return}
        let data = try? Data(contentsOf: url)
        guard let imageData = data else {return}
        guard let image = UIImage(data: imageData) else {return}
        images[index] = image
        
    }
    
    // MARK: Request
    
    func request(endpoint: String){
        networkRequest?.get(resource: NewsModel.self, endpoint: endpoint, completionHandler: { [weak self] (result) in
            switch result {
                case .success(let data):
                    self?.feedModel = data
                    self?.delegate?.requestSucess()
//                    self?.loadImages()
                case .failure(let error):
                    print(error)
                    self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
            }
        })
    }
}
