//
//  GistsController.swift
//  Gists
//
//  Created by OIvanov on 13.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

class GistsController: GistPagesController<Gist, GistList> {
    
    override func viewDidLoad() {
        service = GistsService()

        super.viewDidLoad()
        self.title = "Список Gists"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GistInformationController else {
            assertionFailure("Segue destination not GistInformationController")
            return
        }
        if let indexPath = tableView.indexPathForSelectedRow,
            indexPath.row < items.count  {
            destination.gist = items[indexPath.row]
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GistCell", for: indexPath) as? GistCell else {
            assertionFailure("Ошибка определения ячейки GistCell")
            return UITableViewCell()
        }
        let gist = items[indexPath.row]
        cell.nameLabel.text = gist.getName()
        cell.descriptionLabel.text = gist.description

        if let url = URL(string: gist.owner.avatarUrl) {
            cell.avatarImageView.kf.indicatorType = .activity
            cell.avatarImageView.kf.setImage(with: url)
        }

        return cell
    }
}
