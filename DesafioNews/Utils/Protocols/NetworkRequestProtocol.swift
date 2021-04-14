//
//  NetworkRequestProtocol.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

protocol NetworkRequestProtocol {
    
    func get<T: Codable> (resource: T.Type, endpoint: String, components: [URLQueryItem]?, completionHandler: @escaping (_ result: Result<T, RequestError>) -> Void)
    
    func post(endpoint: String, parameters: [String: Any],
                     completionHandler: @escaping (_ result: Result<Any?, RequestError>) -> Void)
}

enum RequestError: Error {
    case networkError(Error)
    case notHTTPResponse
    case invalidHTTPResponse(Int)
    case parseError(Error)
}
