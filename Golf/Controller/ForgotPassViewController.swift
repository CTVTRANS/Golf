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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileID.delegate = self
        phone.delegate = self
        disableRightBarButton()
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        guard let idCard = profileID.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.idCardEmty.rawValue, in: self)
            return
        }
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.numberPhoneEmty.rawValue, in: self)
            return
        }
        let task = MemberModel.ForgotPass(phone: phoneNumber, idCard: idCard)
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
