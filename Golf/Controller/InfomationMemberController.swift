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
    @IBOutlet weak var landLine: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var topContrains: NSLayoutConstraint!
    
    var member: MemberModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
        setupUI()
        setupKeyBoard()
        let backbutton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .done, target: self, action: #selector(pressedHome))
        navigationItem.leftBarButtonItems = [backbutton]
    }
    
    func setupKeyBoard() {
        name.delegate = self
        birthDay.delegate = self
        idCard.delegate = self
        address.delegate = self
        mail.delegate = self
        landLine.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func setupUI() {
        name.text = member.name
        birthDay.text = member.birthDay
        idCard.text = member.idCard
        address.text = member.address
        mail.text = member.email
        landLine.text = member.landLine
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        topContrains.constant = -80
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
    
    @IBAction func pressedChooseDate(_ sender: Any) {
        if let chooseDate = ChooseBirthDayView.instance() as? ChooseBirthDayView {
            chooseDate.show()
            chooseDate.callBackDate = {[weak self] date in
                self?.birthDay.text = date
            }
        }
        
    }
    
    @IBAction func pressedEdit(_ sender: Any) {
        let task = MemberModel.Update(name: name.text, birthDay: birthDay.text, idCard: idCard.text, address: address.text, email: mail.text, landLine: landLine.text)
        dataWithTask(task, onCompeted: { (_) in
            MemberModel.shared.name = self.name.text!
            MemberModel.shared.birthDay = self.birthDay.text!
            MemberModel.shared.idCard = self.idCard.text!
            MemberModel.shared.address = self.address.text!
            MemberModel.shared.email = self.mail.text!
            MemberModel.shared.landLine = self.landLine.text!
            let cache = Cache<MemberModel>()
            cache.save(object: MemberModel.shared)
            let status = ErrorCode.success
            UIAlertController.showAlertWith(title: "", message: status.decodeError(), in: self)
        }) { (_) in
            
        }
    }
    
    @IBAction func pressedChangepass(_ sender: Any) {
        if let vc = ChangePassViewController.instance() as? ChangePassViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension InfomationMemberController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}
