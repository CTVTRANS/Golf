//
//  AboutTourViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class AboutTourViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        getAoutMap()
    }
    
    func getAoutMap() {
        webView.loadHTMLString("ok", baseURL: nil)
    }
}

extension AboutTourViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
