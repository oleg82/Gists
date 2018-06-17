//
//  GistsService.swift
//  Gists
//
//  Created by OIvanov on 07.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

typealias GistList = [Gist]

class GistsService: GistPageDataService<GistList> {
    override func getPageRouter(page: Int) -> PageRouter? {
        return GistsRouter(page: page)
    }
}


