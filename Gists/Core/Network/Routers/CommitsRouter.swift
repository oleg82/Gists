//
//  CommitsRouter.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

struct CommitsRouter : PageRouter {
    let method: HTTPMethod = .get
    var path: String {
        return "/gists/\(idGist)/commits"
    }
    var parameters: [String : String]? {
        return ["page": "\(page)", "per_page": "\(100)"] // 100 - количество записей на странице
    }
    var page: Int = 1

    var idGist: String
}
