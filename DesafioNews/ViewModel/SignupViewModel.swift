//
//  SignupViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

struct SignupViewModel {
    
    //MARK: - Instances
    
    var networkRequest: NetworkRequestProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init (networkRequest: NetworkRequestProtocol){
        self.networkRequest = networkRequest
    }
    
    //MARK: Functions
    
    func sendValue(nameTextField: String?, emailTextField: String?, passwordTextField: String?) {
        guard let nameTextField = emailTextField else {return}
        guard let emailTextField = emailTextField else {return}
        guard let passwordTextField = passwordTextField else {return}
        let parameters = ["name": nameTextField, "email": emailTextField, "password": passwordTextField]
        let endpoint = "https://mesa-news-api.herokuapp.com/v1/client/auth/signup"
        request(endpoint: endpoint, parameters: parameters)
    }
    
    // MARK: Request
    
    private func request(endpoint: String, parameters: [String: Any]){
        networkRequest?.post(endpoint: endpoint, parameters: parameters, completionHandler: { (result) in
            switch result{
            case .success(_):
                delegate?.requestSucess()
            case .failure(let error):
                switch error {
                    case .invalidHTTPResponse(_):
                        delegate?.requestError(errorMessage: "Email ou senha inválido(s)!")
                    case .networkError(_):
                        delegate?.requestError(errorMessage: "Sem conexão com a internet!")
                    default:
                        delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
                }
            }
        })
    }
}
