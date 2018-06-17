//
//  GistsRouter.swift
//  Gists
//
//  Created by OIvanov on 07.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

struct GistsRouter : PageRouter {
    let method: HTTPMethod = .get
    let path: String = "/gists/public"
    var parameters: [String : String]? {
        return ["page": "\(page)", "per_page": "\(100)"] // 100 - количество записей на странице
    }
    var page: Int = 1
}

