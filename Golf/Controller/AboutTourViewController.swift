//
//  AboutTourViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import CoreData

class AboutTourViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var webView: UIWebView!
    let managerContext = StorageManager.shared.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        getAboutMap()
    }
    
    func getAboutMap() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                guard let company = result.first?.company else {
                    hideLoading()
                    return
                }
                webView.loadHTMLString(company.mapInfo, baseURL: nil)
            }
        } catch {
            print("Failed")
        }
       
    }
}

extension AboutTourViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
