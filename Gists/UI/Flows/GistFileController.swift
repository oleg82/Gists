//
//  GistFileController.swift
//  Gists
//
//  Created by OIvanov on 17.06.2018.
//  Copyright © 2018 geekbrains. All rights reserved.
//

import UIKit
import WebKit

class GistFileController: UIViewController {
    var file: GistFile?
    
    @IBOutlet private var contentWebView: WKWebView!
    @IBOutlet private var loadingView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let file = file, let url = URL(string: file.rawUrl) {
            self.title = file.filename

            startLoading()
            contentWebView.load(URLRequest(url: url))
            contentWebView.navigationDelegate = self
        } else {
            showError("Внутренняя ошибка приложения")
        }
    }
    
    fileprivate func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] alert in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func startLoading() {
        self.view.bringSubview(toFront: loadingView)
        loadingView.startAnimating()
        loadingView.isHidden = false
    }
    
    fileprivate func stopLoading() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
}

extension GistFileController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopLoading()
        showError(error.localizedDescription)
    }
}
