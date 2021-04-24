//
//  NetworkRequestMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

@testable import DesafioNews
import Foundation

class NetworkRequestMock: NetworkRequestProtocol{
    
    var requestCalled = false
    var status = "Loading"
    var endpoint = ""
    private var endpointMock: String
    
    init(endpointMock: String = "News.json") {
        self.endpointMock = endpointMock
    }
    
    func request<T: Codable>(responseType: T.Type, method: RequestMethod, endpoint: String, components: [String : Any]?, key: String?, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        requestCalled = true
        self.endpoint = endpoint
        
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
