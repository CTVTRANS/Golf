//
//  RegisterViewController.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var birthDay: UITextField!
    @IBOutlet weak var idCard: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var confirmCode: UITextField!
    
    @IBOutlet weak var topContrains: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        topContrains.constant = -60
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        topContrains.constant = 40
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func sigupPressed(_ sender: Any) {
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.numberPhoneEmty.rawValue, in: self)
            return
        }
        guard let passWord = pass.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.passwordEmty.rawValue, in: self)
            return
        }
        guard let passWordConfirm = confirmPass.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.passwordConfirmEmty.rawValue, in: self)
            return
        }
        guard let userName = name.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.nameEmty.rawValue, in: self)
            return
        }
        guard let idMember = Int(idCard.text!) else {
             UIAlertController.showAlertWith(title: "", message: ErrorMember.idCardEmty.rawValue, in: self)
            return
        }
        let adressMember = address.text
        let birDay = birthDay.text
        let emailMember = email.text
        guard let telephoneMember = Int(telephone.text!) else {
            return
        }
        guard let code = confirmCode.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.confirmCodeEmty.rawValue, in: self)
            return
        }
        let task = MemberSigup(userName: userName, pass: passWord, confirmPass: passWordConfirm, mobile: phoneNumber, birthDay: birDay!, idCard: idMember, address: adressMember!, email: emailMember!, phone: telephoneMember, code: code)
        dataWithTask(task, onCompeted: { (data) in
            guard let member = data as? MemberModel else {
                return
            }
            if let vc = InfomationMemberController.instance() as? InfomationMemberController {
                vc.member = member
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }) { (_) in
            
        }
    }
}
