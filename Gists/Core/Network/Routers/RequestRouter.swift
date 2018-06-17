//
//  RequestRouter.swift
//  Gists
//
//  Created by OIvanov on 07.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

protocol RequestRouter {
    var baseUrl: URL? { get }
    var fullUrl: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : String]? { get }
}

enum RouterError: Error {
    case invalideUrl
}

extension RequestRouter {
    var baseUrl: URL? {
        return URL(string: "https://api.github.com")
    }
  
    var fullUrl: URL? {
        return baseUrl?.appendingPathComponent(path)
    }

    var parameters: [String : String]? {
        return [String : String]()
    }

    func buildURLRequest() throws -> URLRequest {
        guard let url = fullUrl,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else {
            throw RouterError.invalideUrl
        }
        
        if let parameters = self.parameters {
            let queryItems = parameters.map { key, value in
                return URLQueryItem(name: key, value: value)
            }
            components.queryItems = queryItems
        }

        guard let componentsUrl = components.url else {
            throw RouterError.invalideUrl
        }
        
        var urlRequest = URLRequest(url: componentsUrl)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
