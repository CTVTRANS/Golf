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
        profileID.delegate = self
        phone.delegate = self
        confirmCode.delegate = self
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
        let task = MemberModel.GetCodeSms(idCard: idCard, phone: phoneNumber)
        dataWithTask(task, onCompeted: { (_) in
            
        }) { (_) in
            
        }
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        guard let idCard = Int(profileID.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.idCardEmty.rawValue, in: self)
            return
        }
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.numberPhoneEmty.rawValue, in: self)
            return
        }
        guard let code = confirmCode.text, code != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.confirmCodeEmty.rawValue, in: self)
            return
        }
        let task = MemberModel.ForgotPass(phone: phoneNumber, idCard: idCard, code: code)
        dataWithTask(task, onCompeted: { (_) in
            UIAlertController.showAlertWith(title: "", message: "new Pass send to phone number", in: self)
        }) { (_) in
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ForgotPassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}
