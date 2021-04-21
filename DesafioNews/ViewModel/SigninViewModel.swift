//
//  SigninViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

class SigninViewModel {
    
    //MARK: - Instances
    
    private var bearer = Bearer()
    
    var networkRequest: NetworkRequestProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init(networkRequest: NetworkRequestProtocol) {
        self.networkRequest = networkRequest
    }
    
    //MARK: Functions
    
    func returnApiRequestKey() -> String{
        return bearer.token
    }
    
    func sendValue(emailTextField: String?, passwordTextField: String?) {
        guard let emailTextField = emailTextField else {return}
        guard let passwordTextField = passwordTextField else {return}
        let parameters = ["email": emailTextField, "password": passwordTextField]
        let endpoint = "https://mesa-news-api.herokuapp.com/v1/client/auth/signin"
        request(endpoint: endpoint, parameters: parameters)
        
    }
    
    // MARK: Request
    
    private func request(endpoint: String, parameters: [String: Any]){
        networkRequest?.request(resource: Bearer.self, method: .post, endpoint: endpoint, components: parameters, key: nil, completionHandler: { [weak self] (result) in
            switch result{
                case .success(let data):
                    self?.bearer = data
                    self?.delegate?.requestSucess()
                case .failure(let error):
                    switch error {
                        case .invalidHTTPResponse(_):
                            self?.delegate?.requestError(errorMessage: "Email ou senha inválido(s)!")
                        case .networkError(_):
                            self?.delegate?.requestError(errorMessage: "Sem conexão com a internet!")
                        default:
                            self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
                    }
            }
        })
    }
}
