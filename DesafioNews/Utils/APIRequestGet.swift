//
//  APIRequestGet.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import Foundation

class APIRequestGet: APIRequestGetProtocol {
    
    func getRequest<T: Codable> (endpoint: String, completionHandler: @escaping (_ result: Result<T, RequestError>) -> Void){

        guard let url = URL(string: endpoint) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let key = "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5LCJlbWFpbCI6ImRpbWFzLmdhYnJpZWxAenJvYmFuay5jb20uYnIifQ.a3j7sRx8FIedZCfDGLocduOYpcibfIenX7TVJjv6Sis"
        request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(RequestError.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completionHandler(.failure(RequestError.notHTTPResponse))
                return
            }

            guard 200 ..< 300 ~= httpResponse.statusCode else {
                completionHandler(.failure(RequestError.invalidHTTPResponse(httpResponse.statusCode)))
                return
            }

            do {
                let content = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(content))
            } catch let parseError {
                completionHandler(.failure(RequestError.parseError(parseError)))
            }
        }
        dataTask.resume()
    }
    
}
