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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isInternetAvailable() {
            getCompany()
        } else {
            fetchAboutMap()
        }
    }
    
    func getCompany() {
        let task = CompanyModel.GetInfo()
        dataWithTask(task, onCompeted: { (data) in
            guard let companyResponse = data as? CompanyModel else {
                return
            }
            self.company = companyResponse
            self.webView.loadHTMLString(companyResponse.info, baseURL: nil)
            self.saveCompany()
            
        }) { (_) in
            
        }
    }
    
    func fetchAboutMap() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                guard let company = result.first?.company else {
                    hideLoading()
                    return
                }
                webView.loadHTMLString(company.info, baseURL: nil)
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
