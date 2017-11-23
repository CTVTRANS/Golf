//
//  ListInfotmatchViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

enum TypeShow: Int {
    case listMatch = 0, activity, company
}

class ListInfotmatchViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var contentView: UIView!
    var typeShow: TypeShow = .listMatch
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.isHidden = false
        background.image = #imageLiteral(resourceName: "ic_background")
        switch typeShow {
        case .company:
            background.image = #imageLiteral(resourceName: "ic_info_company")
            contentView.isHidden = true
        default :
            break
        }
        showLoading()
        webview.delegate = self
        webview.loadRequest(URLRequest(url: URL(string: "https://stackoverflow.com/questions/24019707/using-iskindofclass-with-swift")!))
//        webview.loadHTMLString("alo alo", baseURL: nil)
    }
}

extension ListInfotmatchViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
