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
        setupKeyBoard()
    }
    
    func setupKeyBoard() {
        phone.delegate = self
        pass.delegate = self
        confirmCode.delegate = self
        name.delegate = self
        birthDay.delegate = self
        idCard.delegate = self
        address.delegate = self
        email.delegate = self
        telephone.delegate = self
        confirmPass.delegate = self
        
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
        guard let idMember = idCard.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.idCardEmty.rawValue, in: self)
            return
        }
        guard let landLine = telephone.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.numberPhoneEmty.rawValue, in: self)
            return
        }
        let adressMember = address.text
        let birDay = birthDay.text
        let emailMember = email.text
        guard let code = confirmCode.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.confirmCodeEmty.rawValue, in: self)
            return
        }
        let task = MemberModel.Sigup(userName: userName, pass: passWord, confirmPass: passWordConfirm, mobile: phoneNumber, birthDay: birDay, idCard: idMember, address: adressMember, email: emailMember, landLine: landLine, code: code)
        dataWithTask(task, onCompeted: { (data) in
            debugPrint(data)
            guard let _ = data as? MemberModel else {
                
                return
            }
            let message = ErrorCode.success
            UIAlertController.showAlertWith(title: "", message: message.decodeError(), in: self, compeletionHandler: {
                self.navigationController?.popViewController(animated: true)
            })
            return
        }) { (_) in
            
        }
    }
    @IBAction func pressedGetCode(_ sender: Any) {
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorMember.numberPhoneEmty.rawValue, in: self)
            return
        }
        let task = MemberModel.GetCodeSms(phone: phoneNumber)
        dataWithTask(task, onCompeted: { (data) in
            debugPrint(data)
        }) { (_) in
            
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}
