//
//  SigninViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

struct SigninViewModel {
    
    //MARK: - Instances
    
    var apiRequest: APIRequestProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init (apiRequest: APIRequestProtocol){
        self.apiRequest = apiRequest
    }
    
    //MARK: Functions
    
    func sendValue(from emailTextField: String?, passwordTextField: String?) {
        guard let emailTextField = emailTextField else {return}
        guard let passwordTextField = passwordTextField else {return}
        request(email: emailTextField, password: passwordTextField)
        
    }
    
    private func request(email: String, password: String){
        apiRequest?.getRequest(parameters: ["email": email, "password": password], endpoint: "https://mesa-news-api.herokuapp.com/v1/client/auth/signin") { (result) in
            switch result{
            case .success(_):
                delegate?.requestSucess()
            case .failure(let error):
                switch error {
                case .invalidHTTPResponse(_):
                    delegate?.requestError(errorMessage: "Email ou senha incorretos!")
                case .networkError(_):
                    delegate?.requestError(errorMessage: "Sem conexão com a internet!")
                case .notHTTPResponse:
                    delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
                default:
                    delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
                }
            }
        }
    }
}
