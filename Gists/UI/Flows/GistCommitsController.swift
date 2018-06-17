//
//  GistCommitsController.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

class GistCommitsController: GistPagesController<GistCommit, GistCommitList> {
    
    var idGist: String?
    
    override func viewDidLoad() {
        if let idGist = idGist {
            service = GistCommitsService(idGist: idGist)
        }

        super.viewDidLoad()
        self.title = "Коммиты"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath) as? CommitCell else {
            assertionFailure("Ошибка определения ячейки CommitCell")
            return UITableViewCell()
        }
        
        let commit = items[indexPath.row]
        cell.userNameLabel.text = commit.user.login
        cell.addedRowsLabel.text = "\(commit.changeStatus.additions)"
        cell.deletedRowsLabel.text = "\(commit.changeStatus.deletions)"

        if let url = URL(string: commit.user.avatarUrl) {
            cell.userAvatarImageView.kf.indicatorType = .activity
            cell.userAvatarImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
