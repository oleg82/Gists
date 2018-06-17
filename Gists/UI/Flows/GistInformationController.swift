//
//  GistInformationController.swift
//  Gists
//
//  Created by OIvanov on 14.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

class GistInformationController: UITableViewController {
    var gist: Gist? {
        didSet {
            if let gist = gist, let view = HeaderView.create() {
                view.nameLabel.text = gist.getName()
                if let url = URL(string: gist.owner.avatarUrl) {
                    view.avatarImageView.kf.indicatorType = .activity
                    view.avatarImageView.kf.setImage(with: url)
                }
                header = view
                gistFiles = Array(gist.files.values)
            } else {
                header = nil
                gistFiles = nil
            }
        }
    }
    var gistFiles: [GistFile]?
    
    private var header: HeaderView?
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Информация"

        let btn = UIButton()
        btn.setTitle("Коммиты", for: .normal)
        btn.setTitleColor(self.view.tintColor, for: .normal)
        btn.addTarget(self, action: #selector(showCommits), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 100
    }

    @objc func showCommits() {
        guard let controller = UIStoryboard(name: Constants.Storyboards.gistInformation, bundle: nil).instantiateViewController(withIdentifier: "GistCommitsController") as? GistCommitsController else {
            assertionFailure("Не найден контроллер GistCommitsController")
            return
        }
        controller.idGist = gist?.id
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistFiles?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath) as? FileCell else {
            assertionFailure("Ошибка определения ячейки FileCell")
            return UITableViewCell()
        }
        
        let index = indexPath.row
        if let gistFiles = gistFiles, index < gistFiles.count {
            let file = gistFiles[index]
            cell.nameLabel.text = file.filename
            
            if let preview = file.preview {
                cell.stopLoading(preview: preview)
            } else {
                cell.startLoading()
                let loadPreview = LoadPreviewOperation(rawUrl: file.rawUrl)
                let showPreview = ShowPreviewToCellOperation(cell: cell, controller: self)
                
                showPreview.addDependency(loadPreview)
                queue.addOperation(loadPreview)
                OperationQueue.main.addOperation(showPreview)
            }
        }
        cell.delegate = self
        return cell
    }

}

extension GistInformationController: FileCellDelegate {
    func fileCellWasTapped(cell: FileCell) {
        if let gistFiles = gistFiles,
            let indexPath = tableView.indexPath(for: cell),
            indexPath.row < gistFiles.count,
            let controller = UIStoryboard(name: Constants.Storyboards.gistInformation, bundle: nil).instantiateViewController(withIdentifier: "GistFileController") as? GistFileController
        {
            controller.file = gistFiles[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
