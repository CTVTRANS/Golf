//
//  ListInfotmatchViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ListInfotmatchViewController: BaseViewController, MainStoryBoard {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        getInfoActivity()
    }
    
    func getInfoActivity() {
        let task = CompanyModel.GetInfoMatch()
        dataWithTask(task, onCompeted: { (data) in
            if let content = data as? String {
                self.webView.loadHTMLString(content, baseURL: nil)
            }
        }) { (_) in
        }
    }
}

extension ListInfotmatchViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
