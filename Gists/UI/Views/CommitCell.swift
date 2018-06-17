//
//  CommitCell.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

class CommitCell: UITableViewCell {
    @IBOutlet var userNameLabel: UILabel! {
        didSet {
            userNameLabel.text = ""
        }
    }
    @IBOutlet var userAvatarImageView: UIImageView! {
        didSet {
            userAvatarImageView.round(4)
        }
    }
    @IBOutlet var addedRowsLabel: UILabel!
    @IBOutlet var deletedRowsLabel: UILabel!
}
