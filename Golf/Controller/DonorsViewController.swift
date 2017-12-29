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
        case .older2018: // show list donors older 2018
            titleScreen.text = "歷年贊助對象"
            table.isHidden = false
            webView.isHidden = true
            if isInternetAvailable() {
                getDonors()
            } else {
                fetchOlderDonors()
            }
        case .thisYear: // show thisyear donors
            titleScreen.text = "2018贊助對象"
            table.isHidden = true
            webView.isHidden = false
            if isInternetAvailable() {
                getCompany()
            } else {
                fetchThisYearDonors()
            }
        }
    }
    
    func getDonors() {
        let task = DonorsModel.GetList()
        dataWithTask(task, onCompeted: { (data) in
            guard let listDonors = data as? [DonorsModel] else {
                return
            }
            self.listDonors = listDonors
            self.table.reloadData()
            hideLoading()
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: donorsEntity)
            request.returnsObjectsAsFaults = false
            do {
                if let result = try self.managerContext.fetch(request) as? [DonorsCore] {
                    for companyCore in result {
                        self.managerContext.delete(companyCore)
                    }
                    self.storage.saveContext()
                    self.saveListDonors(donors: listDonors)
                }
            } catch {
                print("Failed")
            }
        }) { (_) in
        }
    }
    
    func saveListDonors(donors: [DonorsModel]) {
        let entity = NSEntityDescription.entity(forEntityName: donorsEntity, in: self.managerContext)
        for donor in donors {
            if let donorCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? DonorsCore {
                donorCore.donors = donor
            }
        }
        storage.saveContext()
    }
    
    func getCompany() {
        let task = CompanyModel.GetInfo()
        dataWithTask(task, onCompeted: { (data) in
            guard let companyResponse = data as? CompanyModel else {
                return
            }
            self.company = companyResponse
            self.getCurrentDonors()
            
        }) { (_) in
            
        }
    }
    
    func getCurrentDonors() {
        let task = DonorsModel.GetCurrent()
        dataWithTask(task, onCompeted: { (data) in
            guard let content = data as? String else {
                return
            }
            self.company?.currentDonor = content
            self.webView.loadHTMLString(content, baseURL: nil)
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
            request.returnsObjectsAsFaults = false
            do {
                if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                    if result.first != nil, let companyResult = result.first {
                        companyResult.company = self.company!
                        self.storage.saveContext()
                        return
                    }
                    self.insertCompany(companyModel: self.company!)
                }
            } catch {
                print("Failed")
            }
        }) { (_) in
            debugPrint("")
        }
    }
    
    func insertCompany(companyModel: CompanyModel) {
        let entity = NSEntityDescription.entity(forEntityName: companyEntity, in: self.managerContext)
        if let companyCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? CompanyCore {
            companyCore.company = companyModel
        }
        storage.saveContext()
    }
    
    func fetchOlderDonors() {
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
    
    func fetchThisYearDonors() {
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
            hideLoading()
        }
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
