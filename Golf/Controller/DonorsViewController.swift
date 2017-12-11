//
//  OldDonorsViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import CoreData

class DonorsCell: UITableViewCell {
    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var titleDonors: UILabel!
    @IBOutlet weak var year: UILabel!
    func load(_ donors: DonorsModel) {
        year.text = donors.year.description
        titleDonors.text = donors.name
        content.text = donors.description
    }
}

class DonorsViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var titleScreen: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var table: UITableView!
    var type = TypeDonors.thisYear
    var listDonors = [DonorsModel]()
    let managerContext = StorageManager.shared.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        table.estimatedRowHeight = 140
        webView.delegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        switch type {
        case .older2018: // show list donors older 2018
            titleScreen.text = "歷年贊助對象"
            table.isHidden = false
            webView.isHidden = true
            getOlderDonors()
        case .thisYear: // show thisyear donors
            titleScreen.text = "2018贊助對象"
            table.isHidden = true
            webView.isHidden = false
            getThisYearDonors()
        }

    }
    
    func getOlderDonors() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: donorsEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [DonorsCore] {
                if result.first == nil {
                    hideLoading()
                    return
                }
                for donorsCore in result {
                    listDonors.append(donorsCore.donors)
                }
                table.reloadData()
            }
        } catch {
            print("Failed")
        }
        hideLoading()
    }
    
    func getThisYearDonors() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                if let companyCore = result.first {
                    webView.loadHTMLString(companyCore.currentDonor!, baseURL: nil)
                }
            }
        } catch {
            print("Failed")
        }
        hideLoading()
    }
}

extension DonorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDonors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DonorsCell
        let index = listDonors.count - 1 - indexPath.row
        cell?.load(listDonors[index])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension DonorsViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
