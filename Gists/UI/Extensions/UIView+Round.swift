//
//  UIView+Round.swift
//  Gists
//
//  Created by OIvanov on 13.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

extension UIView {
    func circle() {
        round(self.frame.height/2)
    }

    func round(_ radius: CGFloat) {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
