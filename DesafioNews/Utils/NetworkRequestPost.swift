//
//  NetworkRequest.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

class NetworkRequestPost: NetworkRequestPostProtocol{
    
    func post(endpoint: String, parameters: [String : Any], completionHandler: @escaping (Result<Any?, RequestError>) -> Void) {
        
        guard let url = URL(string: endpoint) else {return}
        let finalBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: [])
        
        var request = URLRequest(url: url)
        request.httpBody = finalBody
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(RequestError.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(RequestError.notHTTPResponse))
                return
            }

            guard 200 ..< 300 ~= httpResponse.statusCode else {
                completionHandler(.failure(RequestError.invalidHTTPResponse(httpResponse.statusCode)))
                return
            }
            
            completionHandler(.success(nil))
        }
        dataTask.resume()
    }
    
}
