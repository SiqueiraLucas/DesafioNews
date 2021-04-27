//
//  NetworkRequestMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

@testable import DesafioNews
import Foundation

class NetworkRequestMock: NetworkRequestProtocol{
    
    //MARK: - Instances
    
    var requestCalled = false
    var responseType: Any?
    var endpoint = ""
    var components: [String : Any]?
    var key: String?
    var method: RequestMethod?
    
    var status = "Loading"
    private var endpointMock: String
    
    //MARK: - Init
    
    init(endpointMock: String = "News.json") {
        self.endpointMock = endpointMock
    }
    
    //MARK: - Functions
    
    func request<T: Codable>(responseType: T.Type, method: RequestMethod, endpoint: String, components: [String : Any]?, key: String?, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        self.requestCalled = true
        self.responseType = responseType
        self.method = method
        self.endpoint = endpoint
        self.components = components
        self.key = key
        
        switch method {
            case .get:
                guard let url = Bundle.main.url(forResource: endpointMock, withExtension: nil) else {
                    completionHandler(.failure(.invalidHTTPResponse(404)))
                    status = "Invalid Url"
                    return
                }

                guard let data = try? Data(contentsOf: url) else {
                    status = "No Data"
                    return
                }
                
                do {
                    let content = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(content))
                    status = "Sucess"
                } catch {
                    status = "Parse Error"
                }
            case .post:
                let url = "https://mesa-news-api.herokuapp.com/v1/client/auth/"
                if endpoint != "\(url)signin" && endpoint != "\(url)signup"{
                    completionHandler(.failure(.invalidHTTPResponse(404)))
                    status = "Invalid Url"
                    return
                }
                
                guard let email = components?["email"] as? String else {return}
                if !email.isValidEmail(){
                    completionHandler(.failure(.invalidHTTPResponse(422)))
                    status = "Invalid Email"
                    return
                }
                
                guard let password = components?["password"] as? String else {return}
                if password.isEmpty{
                    completionHandler(.failure(.invalidHTTPResponse(422)))
                    status = "Invalid Password"
                    return
                }
                
                if let name = components?["name"] as? String{
                    if name.isEmpty{
                        completionHandler(.failure(.invalidHTTPResponse(422)))
                        status = "Invalid Name"
                        return
                    }
                }
                status = "Sucess"
        }
    }
    
}
