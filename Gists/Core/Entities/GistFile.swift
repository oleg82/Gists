//
//  GistFile.swift
//  Gists
//
//  Created by OIvanov on 08.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

struct GistFile: Codable {
    let filename: String
    let rawUrl: String
    var preview: String? = nil

    private enum CodingKeys: String, CodingKey {
        case
        filename,
        rawUrl = "raw_url"
    }
}
