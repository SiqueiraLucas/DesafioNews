//
//  SignupViewModel.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

class SignupViewModel {
    
    //MARK: - Instances
    
    private var bearer = Bearer()
    var endpoint = "https://mesa-news-api.herokuapp.com/v1/client/auth/signup"
    var networkRequest: NetworkRequestProtocol?
    weak var delegate: ViewModelDelegate?
    
    //MARK: Initializer
    
    init() {
        self.networkRequest = NetworkRequest()
    }
    
    //MARK: Functions
    
    func sendValue(nameTextField: String?, emailTextField: String?, passwordTextField: String?) {
        guard let nameTextField = nameTextField else {return}
        guard let emailTextField = emailTextField else {return}
        guard let passwordTextField = passwordTextField else {return}
        let components = ["name": nameTextField, "email": emailTextField, "password": passwordTextField]
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
