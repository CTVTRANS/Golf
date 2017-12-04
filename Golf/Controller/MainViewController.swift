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

    override func viewDidLoad() {
        super.viewDidLoad()
        let cahe = Cache<MemberModel>()
        var member = cahe.fetchObject()
        if member == nil {
            member = MemberModel(idMember: 1, name: "kien", phone: "123", email: "lekien@gmail.com", sex: 0, age: 24, birthDay: "1994/03/08", idCard: "142664602")
            cahe.save(object: member!)
        }
        let managerContext = StorageManager.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: companyEntity, in: managerContext)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try managerContext.fetch(request)
            for data in (result as? [NSManagedObject])! {
                print(data.value(forKey: "name") as? String)
            }
        } catch {
            print("Failed")
        }
        
        let newUser = NSManagedObject(entity: entity!, insertInto: managerContext)
        newUser.setValue("Shashikant", forKey: "name")
        newUser.setValue("1234", forKey: "info")
        newUser.setValue(12.8, forKey: "lat")
        
        do {
           try  managerContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getCompany() {
        let task = CompanyGetInfo()
        dataWithTask(task, onCompeted: { (data) in
            
        }) { (error) in
            
        }
    }
    
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
