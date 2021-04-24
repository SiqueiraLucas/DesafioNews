//
//  NetworkRequest.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 15/04/21.
//

import Foundation

struct NetworkRequest: NetworkRequestProtocol{
    
    //MARK: Request
    
    func request<T: Codable>(responseType: T.Type, method: RequestMethod, endpoint: String, components: [String : Any]?, key: String?, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let request = setupRequest(method: method, endpoint: endpoint, components: components, key: key) else {return}
        
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
    
    //MARK: Setup Request
    
    private func setupRequest(method: RequestMethod, endpoint: String, components: [String: Any]?, key: String?) -> URLRequest?{
        switch method {
            case .get:
                var urlComponents = URLComponents(string: endpoint)
                urlComponents?.queryItems = components?.map {
                    URLQueryItem(name: $0, value: $1 as? String)
                }
                guard let url = urlComponents?.url else {return nil}
                var request = URLRequest(url: url)
                request.httpMethod = method.rawValue
                if let key = key {
                    request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
                }
                return request
            case .post:
                guard let url = URL(string: endpoint) else {return nil}
                let finalBody = try? JSONSerialization.data(withJSONObject: components as Any, options: [])
                var request = URLRequest(url: url)
                request.httpBody = finalBody
                request.httpMethod = method.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                return request
        }
    }
}
