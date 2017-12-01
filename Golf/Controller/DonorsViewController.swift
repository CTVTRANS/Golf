//
//  OldDonorsViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        table.estimatedRowHeight = 140
        webView.delegate = self
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
        hideLoading()
    }
    
    func getThisYearDonors() {
        webView.loadRequest(URLRequest(url: URL(string: "https://www.raywenderlich.com/156966/push-notifications-tutorial-getting-started")!))
    }
}

extension DonorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDonors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DonorsCell
        cell?.load(listDonors[indexPath.row])
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
