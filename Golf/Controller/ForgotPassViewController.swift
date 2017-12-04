//
//  ForgotPassViewController.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ForgotPassViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var profileID: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var confirmCode: UITextField!
    @IBOutlet weak var getCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
    }
    
    @IBAction func pressedGetCode(_ sender: Any) {
        guard let idCard = Int(profileID.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.idCardEmty.rawValue, in: self)
            return
        }
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.numberPhoneEmty.rawValue, in: self)
            return
        }
        let task = MemberGetCode(idCard: idCard, phone: phoneNumber)
        dataWithTask(task, onCompeted: { (data) in
            
        }) { (error) in
            
        }
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        guard let idCard = Int(profileID.text!), let phoneNumber = Int(phone.text!), let code = confirmCode.text, code != "" else {
            return
        }
        let task = MemberForgotPass(phone: phoneNumber, idCard: idCard, code: code)
        dataWithTask(task, onCompeted: { (data) in
            
        }) { (error) in
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
