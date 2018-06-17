//
//  GistCommitsService.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

typealias GistCommitList = [GistCommit]

class GistCommitsService: GistPageDataService<GistCommitList> {
    private var idGist = ""
    
    init(idGist: String) {
        self.idGist = idGist
    }
    
    override func getPageRouter(page: Int) -> PageRouter? {
        return CommitsRouter(page: page, idGist: idGist)
    }
}
