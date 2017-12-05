//
//  SinginViewController.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class SinginViewController: BaseViewController, SecondSroyBoard {
    @IBOutlet weak var phoneTexField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
    }
    
    func showInfomationMember() {
        if let vc = InfomationMemberController.instance() as? InfomationMemberController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedSigin(_ sender: Any) {
        //
        let cahe = Cache<MemberModel>()
        var memberTest = cahe.fetchObject()
        if memberTest == nil {
            memberTest = MemberModel(idMember: 1, name: "kien", phone: "123", address: "my dinh", email: "lekien@gmail.com", sex: 0, age: 24, birthDay: "1994/03/08", idCard: "142664602")
            cahe.save(object: memberTest!)
        }
        if let vc = InfomationMemberController.instance() as? InfomationMemberController {
            vc.member = memberTest
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        /*
        guard let phone = Int(phoneTexField.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.numberPhoneEmty.rawValue, in: self)
            return
        }
        guard let pass = passTextField.text, pass != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.passwordEmty.rawValue, in: self)
            return
        }
        let task = MemberSigin(userName: phone, pass: pass)
        dataWithTask(task, onCompeted: { (data) in
            guard let member = data as? MemberModel else {
                return
            }
            if let vc = InfomationMemberController.instance() as? InfomationMemberController {
                vc.member = member
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }, onError: { (_) in
            
        })
         */
    }
    
    @IBAction func forgotPassPress(_ sender: Any) {
        if let vc = ForgotPassViewController.instance() as? ForgotPassViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func sigupPressed(_ sender: Any) {
        if let vc = RegisterViewController.instance() as? RegisterViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
