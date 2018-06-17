//
//  GistPagesController.swift
//  items
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit
import Kingfisher

class GistPagesController<T: Codable, TList: Codable>: UITableViewController {
    var items = [T]() {
        didSet {
            self.tableView.separatorStyle = (items.count > 0) ? .singleLine : .none
        }
    }
    var service: GistPageDataService<TList>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .primaryActionTriggered)
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        
        self.refreshControl?.beginRefreshing()
        loadFirstPage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        ImageCache.default.clearMemoryCache()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        loadFirstPage()
    }
    
    private func loadFirstPage() {
        guard let service = service else { assertionFailure("Сервис загрузки не задан"); return; }

        self.tableView.endEditing(true)
        
        service.loadFirstPage(success: { [weak self] items in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if let list = items as? [T] {
                    strongSelf.items = list
                }
                strongSelf.reloadTableViewData()
            }
        }) { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
                self?.showError(errorMessage)
                self?.tableView.endEditing(false)
            }
        }
    }
    
    private func loadNextPage() {
        guard let service = service else { assertionFailure("Сервис загрузки не задан"); return; }

        guard service.isNextPage() else { return }
        self.tableView.endEditing(true)
        
        service.loadNextPage(success: { [weak self] items in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if let list = items as? [T] {
                    strongSelf.items = strongSelf.items + list
                }
                strongSelf.reloadTableViewData()
            }
        }) { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
                self?.showError(errorMessage)
                self?.tableView.endEditing(false)
            }
        }
    }
    
    private func reloadTableViewData() {
        refreshControl?.endRefreshing()
        tableView.reloadData()
        tableView.endEditing(false)
    }
    
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        loadNextPage()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        return (indexPath.row == (self.items.count - 1))
    }
}
