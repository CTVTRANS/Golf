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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableRightBarButton()
    }
    @IBAction func pressedLogout(_ sender: Any) {
        
    }
    
    @IBAction func pressedEdit(_ sender: Any) {
        
    }
}
