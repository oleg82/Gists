//
//  GistPageDataService.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

class GistPageDataService<T: Codable>: NetworkService {
    typealias SuccessBlock = (T) -> Void
    typealias SuccessPageBlock = (T, NextPage) -> Void
    
    private var nextPage = 1
    
    func loadFirstPage(success: @escaping SuccessBlock, fail: @escaping FailBlock) {
        nextPage = 1
        loadNextPage(success: success, fail: fail)
    }
    
    func loadNextPage(success: @escaping SuccessBlock, fail: @escaping FailBlock) {
        guard isNextPage() else { return }
        loadPage(page: nextPage, success: { [weak self] (gists, nextPage) in
            self?.nextPage = nextPage
            success(gists)
            }, fail: fail)
    }
    
    func isNextPage() -> Bool {
        return nextPage != -1
    }
    
    func getPageRouter(page: Int) -> PageRouter? {
        assertionFailure("Не реализован метод getPageRouter")
        return nil
    }
    
    private func loadPage(page: Int, success: @escaping SuccessPageBlock, fail: @escaping FailBlock ) {
        if let router = getPageRouter(page: page) {
            load(router: router, success: success, fail: fail)
        }
    }
}
