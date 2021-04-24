//
//  NetworkRequestProtocol.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 10/04/21.
//

import Foundation

protocol NetworkRequestProtocol {
    func request<T: Codable>(responseType: T.Type, method: RequestMethod , endpoint: String, components: [String : Any]?, key: String?, completionHandler: @escaping (Result<T, RequestError>) -> Void)
}

enum RequestEndpoint {
    private static let basePath = "https://mesa-news-api.herokuapp.com/v1/client/"
    static let signin = basePath + "auth/signin"
    static let signup = basePath + "auth/signup"
    static let spotlight = basePath + "news/highlights"
    static var feed = basePath + "news?current_page=&per_page=&published_at="
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
