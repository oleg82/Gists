//
//  PageRouter.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

protocol PageRouter: RequestRouter {
    var page: Int { get }
}
