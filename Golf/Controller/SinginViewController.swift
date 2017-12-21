//
//  SinginViewController.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class SinginViewController: BaseViewController, SecondSroyBoard {
    
    @IBOutlet weak var capcha: UILabel!
    @IBOutlet weak var phoneTexField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var topContrans: NSLayoutConstraint!
    @IBOutlet weak var capchaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTexField.delegate = self
        passTextField.delegate = self
        disableRightBarButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        capcha.text = randomString(length: 4)
    }
    
    func showInfomationMember() {
        if let vc = InfomationMemberController.instance() as? InfomationMemberController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedSigin(_ sender: Any) {
        
        guard let phone = Int(phoneTexField.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.numberPhoneEmty.decodeError(), in: self)
            return
        }
        guard let pass = passTextField.text, pass != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.passwordEmty.decodeError(), in: self)
            return
        }
        
        guard let capchaConfirm = capchaTextField.text, capchaConfirm ==  capcha.text else {
            UIAlertController.showAlertWith(title: "", message: "驗證碼錯誤", in: self)
            self.capcha.text = self.randomString(length: 4)
            return
        }
        let task = MemberModel.Sigin(phone: phone, pass: pass)
        dataWithTask(task, onCompeted: { (data) in
            guard let member = data as? MemberModel else {
                return
            }
            MemberModel.shared = member
            let cache = Cache<MemberModel>()
            cache.save(object: member)
            if let vc = InfomationMemberController.instance() as? InfomationMemberController {
                vc.member = member
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }, onError: { (_) in
            self.capcha.text = self.randomString(length: 4)
        })
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        topContrans.constant = 20
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        topContrans.constant = 80
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
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

extension SinginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
    
    func randomString(length: Int) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}
