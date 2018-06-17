//
//  ShowPreviewToCellOperation.swift
//  Gists
//
//  Created by OIvanov on 15.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import Foundation

import UIKit

class ShowPreviewToCellOperation: Operation {
    private weak var cell: FileCell?
    private weak var controller: GistInformationController?
    
    init(cell: FileCell, controller: GistInformationController) {
        self.cell = cell
        self.controller = controller
    }
    
    override func main() {
        guard let cell = cell,
            let controller = controller,
            let loadPreview = dependencies[0] as? LoadPreviewOperation else { return }

        if let files = controller.gistFiles,
            let indexPath = controller.tableView.indexPath(for: cell),
            indexPath.row < files.count
        {
            controller.gistFiles?[indexPath.row].preview = loadPreview.preview
        }
        
        cell.stopLoading(preview: loadPreview.preview)
        controller.tableView.beginUpdates()
        controller.tableView.endUpdates()
    }
    
}
