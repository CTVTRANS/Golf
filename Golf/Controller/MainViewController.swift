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
    
    let managerContext = StorageManager.shared.managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        getCompany()
        getDonors()
    }
    
    // MARK: API request
    
    func getCompany() {
        let task = GetCompanyInfo()
        dataWithTask(task, onCompeted: { (data) in
            guard let commapny = data as? CompanyModel else {
                return
            }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
            request.returnsObjectsAsFaults = false
            do {
                if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                    if result.first != nil {
                        return
                    }
                    self.saveCompany(companyModel: commapny)
                }
            } catch {
                print("Failed")
            }
        }) { (_) in
             let companytest = CompanyModel(name: "hanoi university of seience and technology", adress: "so 1 dai co viet", website: "www.hust.edu.vn", phone: "842436231732", latitude: 21.0062876, lontitude: 105.8423921, info: "alo alo", mapInfo: "bloblobloblo", currentDonor: "okokokok")
             self.saveCompany(companyModel: companytest)
        }
    }
    
    func getDonors() {
        let task = DonorsList()
        dataWithTask(task, onCompeted: { (data) in
            guard let listDonors = data as? [DonorsModel] else {
                return
            }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: donorsEntity)
            request.returnsObjectsAsFaults = false
            do {
                if let result = try self.managerContext.fetch(request) as? [DonorsCore] {
                    if result.first != nil {
                        return
                    }
                    self.saveListDonors(donors: listDonors)
                }
            } catch {
                print("Failed")
            }
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
    
    @IBAction func pressShowDetailNews(_ sender: Any) {
        if let vc = NewsDetailViewController.instance() as? NewsDetailViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
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
