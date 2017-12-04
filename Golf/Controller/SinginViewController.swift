//
//  SinginViewController.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class SinginViewController: BaseViewController, SecondSroyBoard {
    @IBOutlet weak var phoneTexField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
    }
    
    func showInfomationMember() {
        if let vc = InfomationMemberController.instance() as? InfomationMemberController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedSigin(_ sender: Any) {
        let phone = phoneTexField.text
        let pass = passTextField.text
        if phone != "" && pass != "" {
            debugPrint("call api")
          
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
