//
//  AttendSuccessViewController.swift
//  Golf
//
//  Created by le kien on 12/1/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class AttendSuccessViewController: BaseViewController, SecondSroyBoard {

    @IBOutlet weak var name: UILabel!
    var titleName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = titleName
    }
}
