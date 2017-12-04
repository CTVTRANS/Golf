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
        let idCardMember: Int? = idCard.text == "" ? nil: Int(idCard.text!)
        let phone: Int? = telephone.text == "" ? nil: Int(telephone.text!)
        let task = MemberUpdate(birthDay: birthDay.text,
                                idCard: idCardMember,
                                address: address.text,
                                email: mail.text,
                                phone: phone)
        dataWithTask(task, onCompeted: { (data) in
            
        }) { (error) in
            
        }
    }
}
