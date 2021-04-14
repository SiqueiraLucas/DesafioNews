//
//  NetworkRequestMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 14/04/21.
//

@testable import DesafioNews
import Foundation

class NetworkRequestMock: NetworkRequestProtocol{
    
    var status = "Loading"
    
    func get<T: Codable>(resource: T.Type, endpoint: String, components: [URLQueryItem]?, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let url = Bundle.main.url(forResource: endpoint, withExtension: nil) else {
            status = "Invalid Url"
            completionHandler(.failure(RequestError.notHTTPResponse))
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
    }
    
    func post(endpoint: String, parameters: [String : Any], completionHandler: @escaping (Result<Any?, RequestError>) -> Void) {
        
    }
    
    
}
