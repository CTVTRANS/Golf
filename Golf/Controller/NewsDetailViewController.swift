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
    var news: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        setupUI()
    }
    
    func setupUI() {
       webView.loadHTMLString(news.content, baseURL: nil)
    }
}

extension NewsDetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
