//
//  APIRequestProtocol.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

protocol APIRequestProtocol {
    func getRequest(parameters: [String: Any], endpoint: String,
                     completionHandler: @escaping (_ result: Result<Any?, RequestError>) -> Void)
}

enum RequestError: Error {
    case networkError(Error)
    case notHTTPResponse
    case invalidHTTPResponse(Int)
    case parseError(Error)
}
