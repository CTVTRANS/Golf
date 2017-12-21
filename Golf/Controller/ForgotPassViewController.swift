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
    @IBOutlet weak var topContrains: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileID.delegate = self
        phone.delegate = self
        disableRightBarButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        topContrains.constant = 20
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        topContrains.constant = 80
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        guard let idCard = profileID.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.idCardEmty.decodeError(), in: self)
            return
        }
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.numberPhoneEmty.decodeError(), in: self)
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
