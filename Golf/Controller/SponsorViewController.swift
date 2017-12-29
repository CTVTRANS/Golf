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
    @IBOutlet weak var titleSponsor: UILabel!
    @IBOutlet weak var year: UILabel!
    func load(_ sponsor: SponsorModel) {
        year.text = sponsor.year.description
        titleSponsor.text = sponsor.name
        content.text = sponsor.description
    }
}

class SponsorViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var titleScreen: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var table: UITableView!
    var type = TypeSponsor.thisYear
    var listSponsors = [SponsorModel]()
    let managerContext = StorageManager.shared.managedObjectContext
    private let storage = StorageManager.shared
    fileprivate var company: CompanyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        table.estimatedRowHeight = 140
        webView.delegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch type {
        case .older2018: // show list sponsors older 2018
            titleScreen.text = "歷年贊助對象"
            table.isHidden = false
            webView.isHidden = true
            if isInternetAvailable() {
                getSponsors()
            } else {
                fetchOlderSponsors()
            }
        case .thisYear: // show this year sponsor
            table.isHidden = true
            webView.isHidden = false
            if isInternetAvailable() {
                getCurrentSponsor()
            } else {
                fetchThisYearSponsor()
            }
        }
    }
    
    func getSponsors() {
        let task = SponsorModel.GetList()
        dataWithTask(task, onCompeted: { (data) in
            guard let sponsors = data as? [SponsorModel
                ] else {
                return
            }
            self.listSponsors = sponsors
            self.table.reloadData()
            hideLoading()
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: sponsorsEntity)
            request.returnsObjectsAsFaults = false
            do {
                if let result = try self.managerContext.fetch(request) as? [SponsorsCore] {
                    for companyCore in result {
                        self.managerContext.delete(companyCore)
                    }
                    self.storage.saveContext()
                    self.saveListSponsors(sponsors: sponsors)
                }
            } catch {
                print("Failed")
            }
        }) { (_) in
        }
    }
    
    func saveListSponsors(sponsors: [SponsorModel]) {
        let entity = NSEntityDescription.entity(forEntityName: sponsorsEntity, in: self.managerContext)
        for sponsor in sponsors {
            if let sponsorCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? SponsorsCore {
                sponsorCore.sponsors = sponsor
            }
        }
        storage.saveContext()
    }
    
    func getCurrentSponsor() {
        let task = SponsorModel.GetCurrent()
        dataWithTask(task, onCompeted: { (data) in
            guard let sponsor = data as? SponsorModel else {
                return
            }
            self.titleScreen.text = sponsor.name
            self.webView.loadHTMLString(sponsor.description, baseURL: nil)
            let cacheSponsor = Cache<SponsorModel>()
            cacheSponsor.remove()
            cacheSponsor.save(object: sponsor)
        }) { (_) in
            
        }
    }
    
//    func insertCompany(companyModel: CompanyModel) {
//        let entity = NSEntityDescription.entity(forEntityName: companyEntity, in: self.managerContext)
//        if let companyCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? CompanyCore {
//            companyCore.company = companyModel
//        }
//        storage.saveContext()
//    }
    
    func fetchOlderSponsors() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: sponsorsEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [SponsorsCore] {
                if result.first == nil {
                    hideLoading()
                    return
                }
                for sponsorCore in result {
                    listSponsors.append(sponsorCore.sponsors)
                }
                table.reloadData()
            }
        } catch {
            print("Failed")
        }
        hideLoading()
    }
    
    func fetchThisYearSponsor() {
        let cacheSponsor = Cache<SponsorModel>()
        let sponsor = cacheSponsor.fetchObject()
        self.titleScreen.text = sponsor?.name
        webView.loadHTMLString((sponsor?.description)!, baseURL: nil)
    }
}

extension SponsorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSponsors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DonorsCell
        let index = listSponsors.count - 1 - indexPath.row
        cell?.load(listSponsors[index])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension SponsorViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
