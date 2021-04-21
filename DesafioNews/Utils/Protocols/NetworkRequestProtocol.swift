//
//  NetworkRequestProtocol.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

protocol NetworkRequestProtocol {
    func request<T: Codable>(resource: T.Type, method: RequestMethod, endpoint: String, components: [String : Any]?, key: String?, completionHandler: @escaping (Result<T, RequestError>) -> Void)
}

enum RequestError: Error {
    case networkError(Error)
    case notHTTPResponse
    case invalidHTTPResponse(Int)
    case parseError(Error)
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}
