//
//  Gist.swift
//  Gists
//
//  Created by OIvanov on 08.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

struct Gist: Codable {
    let id: String
    let files: [String: GistFile]
    let description: String?
    let owner: Owner

    private enum CodingKeys: String, CodingKey {
        case
        id,
        files,
        description,
        owner
    }
    
    func getFirstFileName() -> String {
        return files.count > 0 ? Array(files)[0].key : ""
    }
    
    func getName() -> String {
        return "\(owner.login) / \(getFirstFileName())"
    }

}
