//
//  NetworkService.swift
//  Gists
//
//  Created by OIvanov on 08.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

class NetworkService {
    typealias ErrorText = String
    typealias NextPage = Int
    typealias FailBlock = (ErrorText) -> Void

    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func load <Response: Codable> (
        router: RequestRouter,
        success: @escaping (Response, NextPage) -> Void,
        fail: @escaping (ErrorText) -> Void
    ) {
        do {
            let urlRequest = try router.buildURLRequest()
            session.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    fail(error?.localizedDescription ?? ErrorMessage.runRequest)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    fail(ErrorMessage.parse)
                    return
                }
                if httpResponse.statusCode != HTTPStatusCodes.OK.rawValue {
                    if httpResponse.statusCode == HTTPStatusCodes.RequestTimeout.rawValue {
                        fail(ErrorMessage.timeout)
                    } else {
                        fail(ErrorMessage.runRequest)
                    }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let gists = try decoder.decode(Response.self, from: data)
                    let nextPage = httpResponse.findLinkPage(relation: "next")
                    success(gists, nextPage)
                } catch {
                    fail(ErrorMessage.parse)
                }
            }.resume()
        } catch  {
            fail(ErrorMessage.runRequest)
        }
    }
    
}
