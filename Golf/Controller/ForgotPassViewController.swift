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
    @IBOutlet weak var confirmCode: UITextField!
    @IBOutlet weak var getCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
    }
    @IBAction func pressedGetCode(_ sender: Any) {
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        let idNo = profileID.text
        let phoneNumber = phone.text
        if idNo != "" && phoneNumber != "" {
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
