//
//  InfomationMemberController.swift
//  Golf
//
//  Created by le kien on 12/2/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class InfomationMemberController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var birthDay: UITextField!
    @IBOutlet weak var idCard: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var topContrains: NSLayoutConstraint!
    
    var member: MemberModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
        setupUI()
        setupKeyBoard()
    }
    
    func setupKeyBoard() {
        name.delegate = self
        birthDay.delegate = self
        idCard.delegate = self
        address.delegate = self
        mail.delegate = self
        telephone.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func setupUI() {
        name.text = member.name
        birthDay.text = member.birthDay
        idCard.text = member.idCard
        address.text = member.address
        mail.text = member.email
        telephone.text = member.phone
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
    
    @IBAction func pressedLogout(_ sender: Any) {
        let cahe = Cache<MemberModel>()
        cahe.remove()
        navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func pressedEdit(_ sender: Any) {

        let idCardMember: Int? = idCard.text == "" ? nil: Int(idCard.text!)
        let phone: Int? = telephone.text == "" ? nil: Int(telephone.text!)
        let task = MemberModel.Update(birthDay: birthDay.text, idCard: idCardMember, address: address.text, email: mail.text, phone: phone)
        dataWithTask(task, onCompeted: { (_) in
            UIAlertController.showAlertWith(title: "", message: "change suess", in: self)
        }) { (_) in
            
        }
    }
}

extension InfomationMemberController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}
