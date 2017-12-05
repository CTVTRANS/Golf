//
//  NewsDetailViewController.swift
//  Golf
//
//  Created by le kien on 11/30/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class NewsDetailViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        getNews()
    }
    
    func getNews() {
        let task = NewsList()
        dataWithTask(task, onCompeted: { (data) in
            guard let data = data as? NewsModel else {
                return
            }
            self.webView.loadHTMLString(data.content, baseURL: nil)
        }) { (_) in
            
        }
    }
}

extension NewsDetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
