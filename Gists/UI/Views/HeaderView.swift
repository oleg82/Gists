//
//  HeaderView.swift
//  Gists
//
//  Created by OIvanov on 15.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = ""
        }
    }
    @IBOutlet var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.round(4)
        }
    }

    class func create() -> HeaderView? {
        return UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? HeaderView
    }

}
