//
//  ViewController.swift
//  Golf
//
//  Created by le kien on 11/20/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: BaseViewController {
    
    @IBOutlet weak var table: UITableView!
    fileprivate let managerContext = StorageManager.shared.managedObjectContext
    fileprivate var company: CompanyModel?
    fileprivate var page = 1
    fileprivate var listNews = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCompany()
        getDonors()
        getNews()
    }
    
    // MARK: API request
    
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
    
    func getDonors() {
        let task = DonorsModel.GetList()
        dataWithTask(task, onCompeted: { (data) in
            guard let listDonors = data as? [DonorsModel] else {
                return
            }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: donorsEntity)
            request.returnsObjectsAsFaults = false
            do {
                if let result = try self.managerContext.fetch(request) as? [DonorsCore] {
                    if listDonors.count > result.count {
                        let donors = listDonors[result.count..<listDonors.count]
                        let newDonors: [DonorsModel] = Array(donors)
                        self.saveListDonors(donors: newDonors)
                    }
                }
            } catch {
                print("Failed")
            }
        }) { (_) in
        }
    }
    
    func getCurrentDonors() {
        let task = DonorsModel.GetCurrent()
        dataWithTask(task, onCompeted: { (data) in
            if let content = data as? String {
                self.company?.currentDonor = content
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
                request.returnsObjectsAsFaults = false
                do {
                    if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                        if result.first != nil {
                            return
                        }
                        self.saveCompany(companyModel: self.company!)
                    }
                } catch {
                    print("Failed")
                }
            }
        }) { (_) in
        }
    }
    
    func getNews() {
        let task = NewsModel.GetList(pager: page)
        dataWithTask(task, onCompeted: { (data) in
            guard let arrNews = data as? [NewsModel] else {
                return
            }
            self.listNews = arrNews
            self.table.reloadData()
        }) { (_) in
        }
    }
    
    // MARK: Save company and donors to core data
    
    func saveCompany(companyModel: CompanyModel) {
        let entity = NSEntityDescription.entity(forEntityName: companyEntity, in: self.managerContext)
        if let companyCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? CompanyCore {
            companyCore.company = companyModel
        }
        do {
           try  managerContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func saveListDonors(donors: [DonorsModel]) {
         let entity = NSEntityDescription.entity(forEntityName: donorsEntity, in: self.managerContext)
        for donor in donors {
            if let donorCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? DonorsCore {
                donorCore.donors = donor
            }
        }
        do {
            try  managerContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    // MARK: Action control
    
    @IBAction func pressedAboutUs(_ sender: Any) {
        if let vc = AboutUsViewController.instance() as? AboutUsViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedContact(_ sender: Any) {
        if let vc = ContactUsViewController.instance() as? ContactUsViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedEvent(_ sender: Any) {
        if let vc = EventViewController.instance() as? EventViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedDiscount(_ sender: Any) {
        if let vc = DiscountViewController.instance() as? DiscountViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedAttendance(_ sender: Any) {
        if let vc = AttendanceViewController.instance() as? AttendanceViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedJackpot(_ sender: Any) {
        if let vc = JackpotViewController.instance() as? JackpotViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as? NewsViewCell
        cell?.loadNews(listNews[indexPath.row], at: indexPath.row + 1)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsModel = listNews[indexPath.row]
        if let vc = NewsDetailViewController.instance() as? NewsDetailViewController {
            vc.news = newsModel
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
