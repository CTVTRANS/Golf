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

    }
    
    @IBAction func pressedSigin(_ sender: Any) {
        let phone = phoneTexField.text
        let pass = passTextField.text
        if phone != "" && pass != "" {
            
        }
    }
    
    @IBAction func pressedOpenWeb(_ sender: Any) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
