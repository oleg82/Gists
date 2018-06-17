//
//  LoadPreviewOperation.swift
//  Gists
//
//  Created by OIvanov on 15.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

// NOTE: можно озоботиться хранением контента файла в файловом хранилище
// для его дальнейшего отображения целиком
class LoadPreviewOperation: Operation {
    private let rawUrl: String
    var preview: String?

    init(rawUrl: String) {
        self.rawUrl = rawUrl
    }
    
    override func main() {
        guard let rawUrl = URL(string: rawUrl),
            let data = try? Data(contentsOf: rawUrl),
            let content = String(data: data, encoding: .utf8) else { return }
        
        makePreview(content: content)
    }
    
    private func makePreview(content: String) {
        let maxCount = 500
        if content.count < maxCount {
            preview = content
        } else {
            preview = String(content.prefix(maxCount - 1))
        }
    }

}
