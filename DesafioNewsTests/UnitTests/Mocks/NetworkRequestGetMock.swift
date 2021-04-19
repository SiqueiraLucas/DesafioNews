//
//  NetworkRequestGetMock.swift
//  DesafioNewsTests
//
//  Created by Lucas Siqueira on 15/04/21.
//

@testable import DesafioNews
import Foundation

class NetworkRequestGetMock: NetworkRequestGetProtocol{
    
    var requestCalled = false
    var status = "Loading"
    
    func get<T: Codable>(resource: T.Type, endpoint: String, components: [URLQueryItem]?, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        requestCalled = true
        
        guard let url = Bundle.main.url(forResource: endpoint, withExtension: nil) else {
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
    }
    
}
