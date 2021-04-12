//
//  SignupViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

struct SignupViewModel {
    
    //MARK: - Instances
    
    var apiRequest: APIRequestProtocol?
    
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init (apiRequest: APIRequestProtocol){
        self.apiRequest = apiRequest
    }
    
    //MARK: Functions
    
    func sendValue(nameTextField: String?, emailTextField: String?, passwordTextField: String?) {
        guard let nameTextField = emailTextField else {return}
        guard let emailTextField = emailTextField else {return}
        guard let passwordTextField = passwordTextField else {return}
        request(name: nameTextField, email: emailTextField, password: passwordTextField)
        
    }
    
    // MARK: Request
    
    private func request(name: String, email: String, password: String){
        apiRequest?.getRequest(parameters: ["name": name, "email": email, "password": password], endpoint: "https://mesa-news-api.herokuapp.com/v1/client/auth/signup") { (result) in
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
        }
    }
}
