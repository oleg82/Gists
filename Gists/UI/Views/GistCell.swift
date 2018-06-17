//
//  GistCell.swift
//  Gists
//
//  Created by OIvanov on 13.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

class GistCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = ""
        }
    }
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = ""
        }
    }
    @IBOutlet var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.round(4)
        }
    }
}
