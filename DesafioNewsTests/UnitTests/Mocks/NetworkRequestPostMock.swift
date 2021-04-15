//
//  NetworkRequestMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 14/04/21.
//

@testable import DesafioNews
import Foundation

class NetworkRequestPostMock: NetworkRequestPostProtocol{
    
    var status = "Loading"
    
    func post(endpoint: String, parameters: [String : Any], completionHandler: @escaping (Result<Any?, RequestError>) -> Void) {
        
        let url = "https://mesa-news-api.herokuapp.com/v1/client/auth/"
        if endpoint != "\(url)signin" && endpoint != "\(url)signup"{
            completionHandler(.failure(.invalidHTTPResponse(404)))
            status = "Invalid Url"
            return
        }
        
        guard let email = parameters["email"] as? String else {return}
        if !email.isValidEmail(){
            completionHandler(.failure(.invalidHTTPResponse(422)))
            status = "Invalid Email"
            return
        }
        
        guard let password = parameters["password"] as? String else {return}
        if password.isEmpty{
            completionHandler(.failure(.invalidHTTPResponse(422)))
            status = "Invalid Password"
            return
        }
        
        if let name = parameters["name"] as? String{
            if name.isEmpty{
                completionHandler(.failure(.invalidHTTPResponse(422)))
                status = "Invalid Name"
                return
            }
        }
        completionHandler(.success(nil))
        status = "Sucess"
        
    }
    
}
