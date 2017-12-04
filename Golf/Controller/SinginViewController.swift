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
            
        }, onError: { (error) in
            
        })
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
