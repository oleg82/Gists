//
//  Owner.swift
//  Gists
//
//  Created by OIvanov on 08.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case
        id,
        login,
        avatarUrl = "avatar_url"
    }
}
