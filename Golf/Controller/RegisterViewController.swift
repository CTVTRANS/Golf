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
    
    @IBOutlet weak var botContrains: NSLayoutConstraint!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var getCodeButton: UIButton!
    var counter = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
        setupKeyBoard()
    }
    
    func setupKeyBoard() {
        phone.delegate = self
        phone.keyboardType = .numberPad
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
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            botContrains.constant = keyboardRectangle.height
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        botContrains.constant = 0
    }
    
    @IBAction func sigupPressed(_ sender: Any) {
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.numberPhoneError.decodeError(), in: self)
            return
        }
        guard let passWord = pass.text, passWord != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        guard let passWordConfirm = confirmPass.text, passWordConfirm != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        guard let userName = name.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        
        guard let birDay = birthDay.text, birDay != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        
        guard let idMember = idCard.text else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        
        guard let adressMember = address.text, adressMember != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        
        guard let emailMember = email.text, emailMember != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        
        guard let landLine = telephone.text, landLine != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        
        guard let code = confirmCode.text, code != "" else {
            UIAlertController.showAlertWith(title: "", message: ErrorMessage.pleaseFillFullInfo.rawValue, in: self)
            return
        }
        
        let task = MemberModel.Sigup(userName: userName, pass: passWord, confirmPass: passWordConfirm, mobile: phoneNumber, birthDay: birDay, idCard: idMember, address: adressMember, email: emailMember, landLine: landLine, code: code)
        dataWithTask(task, onCompeted: { (_) in
            let message = ErrorCode.success
            UIAlertController.showAlertWith(title: "", message: message.decodeError(), in: self, compeletionHandler: {
                self.navigationController?.popViewController(animated: true)
            })
        }) { (_) in
        }
    }
    
    @IBAction func pressedChooseBirDay(_ sender: Any) {
        let chooseDate = ChooseBirthDayView.instance() as? ChooseBirthDayView
        chooseDate?.show()
        chooseDate?.callBackDate = { [weak self] date in
            self?.birthDay.text = date
        }
    }
    
    @IBAction func pressedGetCode(_ sender: Any) {
        guard let phoneNumber = Int(phone.text!) else {
            UIAlertController.showAlertWith(title: "", message: ErrorCode.numberPhoneEmty.decodeError(), in: self)
            return
        }
        let time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer(timer:)), userInfo: nil, repeats: true)
        getCodeButton.isEnabled = false
        let task = MemberModel.GetCodeSms(phone: phoneNumber)
        dataWithTask(task, onCompeted: { (data) in
            debugPrint(data)
        }) { (error) in
            UIAlertController.showAlertWith(title: "", message: error, in: self)
            time.invalidate()
            self.getCodeButton.isEnabled = true
            self.counterLabel.text = " 取驗證碼 "
        }
    }
    
    @objc func updateTimer(timer: Timer) {
        counter -= 1
        counterLabel.text = "(\(counter)s)"
        if counter <= 0 {
            counterLabel.text = " 取驗證碼 "
            timer.invalidate()
            counter = 60
            getCodeButton.isEnabled = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}

extension String {
    var checkIDCard: Bool {
        if self.count == 10 {
            let index1 = self.index(self.startIndex, offsetBy: 1)
            let number = self[index1...self.endIndex]
            let charater = self[..<index1]
            guard Int(number) != nil else {
                return false
            }
            guard Int(charater) != nil else {
                return true
            }
        }
        return false
    }
    
    var checkPass: Bool {
        if self.count <= 12 && self.count >= 8 {
            if Int(self) != nil {
                return false// self all number
            }
            for character in self {
                if character == " " {
                    return false
                }
                guard Int(String(character)) != nil else {
                    return true// self has number
                }
            }
        }
        return false
    }
}

extension Int {
    var checkPhone: Bool {
        guard String(self).count == 9 else {
            return false
        }
        return true
    }
}
