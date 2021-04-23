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
    var endpoint = "https://mesa-news-api.herokuapp.com/v1/client/auth/signin"
    var networkRequest: NetworkRequestProtocol?
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init() {
        self.networkRequest = NetworkRequest()
    }
    
    //MARK: Functions
    
    func returnApiRequestKey() -> String{
        return bearer.token
    }
    
    func sendValue(emailTextField: String?, passwordTextField: String?) {
        guard let emailTextField = emailTextField else {return}
        guard let passwordTextField = passwordTextField else {return}
        let components = ["email": emailTextField, "password": passwordTextField]
        request(components: components)
        
    }
    
    // MARK: Request
    
    private func request(components: [String: Any]){
        networkRequest?.request(resource: Bearer.self, method: .post, endpoint: endpoint, components: components, key: nil, completionHandler: { [weak self] (result) in
            guard let self = self else {return}
            switch result{
                case .success(let data):
                    self.bearer = data
                    self.delegate?.requestSucess()
                case .failure(let error):
                    switch error {
                        case .invalidHTTPResponse(_):
                            self.delegate?.requestError(errorMessage: "Email ou senha inválido(s)!")
                        case .networkError(_):
                            self.delegate?.requestError(errorMessage: "Sem conexão com a internet!")
                        default:
                            self.delegate?.requestError(errorMessage: "Erro, tente novamente mais tarde!")
                    }
            }
        })
    }
}
