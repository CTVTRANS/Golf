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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
    }
    
    @IBAction func sigupPressed(_ sender: Any) {
        
    }
}
