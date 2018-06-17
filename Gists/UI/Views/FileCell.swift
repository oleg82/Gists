//
//  FileCell.swift
//  Gists
//
//  Created by OIvanov on 14.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit

protocol FileCellDelegate: class {
    func fileCellWasTapped(cell: FileCell)
}

class FileCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = ""
        }
    }
    @IBOutlet var previewLabel: UILabel! {
        didSet {
            previewLabel.text = ""
        }
    }
    
    @IBOutlet private var previewBorderView: UIView!
    @IBOutlet private var showContentButton: UIButton! {
        didSet {
            showContentButton.isEnabled = false
        }
    }
    @IBOutlet private var previewLoadingView: UIActivityIndicatorView!
    weak var delegate: FileCellDelegate?
    
    @IBAction func showButtonPressed(_ sender: Any) {
        if let delegate = delegate {
            delegate.fileCellWasTapped(cell: self)
        }
    }
    
    func startLoading() {
        previewLoadingView.startAnimating()
        previewLoadingView.isHidden = false
        previewLabel.text = ""
        showContentButton.isEnabled = false
    }

    func stopLoading(preview: String?) {
        if let text = preview, !text.isEmpty {
            showContentButton.isEnabled = true
            previewLabel.text = text
        } else {
            previewLabel.text = "Контент не доступен"
            showContentButton.isEnabled = false
        }
        previewBorderView.round(4)

        previewLoadingView.stopAnimating()
        previewLoadingView.isHidden = true
    }
}
