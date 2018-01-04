//
//  ChangePassViewController.swift
//  Golf
//
//  Created by le kien on 12/11/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ChangePassViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var oldPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var topContrains: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPass.delegate = self
        newPass.delegate = self
        confirmPass.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        topContrains.constant = 10
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

    @IBAction func pressedChange(_ sender: Any) {
        guard let oldPass = oldPass.text, oldPass != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.passwordWrongFormat.decodeError(), in: self)
            return
        }
        guard let newPass = newPass.text, newPass != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.passwordWrongFormat.decodeError(), in: self)
            return
        }
        guard let confirmpass = confirmPass.text, confirmpass != "" else {
             UIAlertController.showAlertWith(title: "", message: ErrorCode.passwordWrongFormat.decodeError(), in: self)
            return
        }
        let task = MemberModel.ChangePass(oldPass: oldPass, newPass: newPass, confirmPass: confirmpass)
        dataWithTask(task, onCompeted: { (data) in
            if let newToken = data as? String {
                MemberModel.shared.accessToken = newToken
                let cache = Cache<MemberModel>()
                cache.save(object: MemberModel.shared)
                UIAlertController.showAlertWith(title: "", message: ErrorCode.success.decodeError(), in: self, compeletionHandler: {
                    self.navigationController?.popViewController(animated: false)
                })
                return
            }
        }) { (_) in
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ChangePassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}
