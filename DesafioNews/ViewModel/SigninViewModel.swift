//
//  SigninViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

class SigninViewModel {
    
    //MARK: - Instances
    
    var networkRequest: NetworkRequestPostProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init() {
        self.networkRequest = NetworkRequestPost()
    }
    
    //MARK: Functions
    
    func sendValue(emailTextField: String?, passwordTextField: String?) {
        guard let emailTextField = emailTextField else {return}
        guard let passwordTextField = passwordTextField else {return}
        let parameters = ["email": emailTextField, "password": passwordTextField]
        let endpoint = "https://mesa-news-api.herokuapp.com/v1/client/auth/signin"
        request(endpoint: endpoint, parameters: parameters)
        
    }
    
    // MARK: Request
    
    private func request(endpoint: String, parameters: [String: Any]){
        networkRequest?.post(endpoint: endpoint, parameters: parameters, completionHandler: { [weak self] (result) in
            switch result{
            case .success(_):
                self?.delegate?.requestSucess()
            case .failure(let error):
                switch error {
                    case .invalidHTTPResponse(_):
                        self?.delegate?.requestError(errorMessage: "Email ou senha incorretos!")
                    case .networkError(_):
                        self?.delegate?.requestError(errorMessage: "Sem conexão com a internet!")
                    default:
                        self?.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
                }
            }
        })
    }
}
