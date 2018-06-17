//
//  GistCommit.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

struct ChangeStatus: Codable {
    let additions: Int
    let deletions: Int
    
    private enum CodingKeys: String, CodingKey {
        case
        additions,
        deletions
    }
}

struct GistCommit: Codable {
    let changeStatus: ChangeStatus
    let user: Owner

    private enum CodingKeys: String, CodingKey {
        case
        changeStatus = "change_status",
        user
    }
}
