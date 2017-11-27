//
//  SubmitAttendanceViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class SubmitAttendanceViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var name: UILabel!
    var type: TypeAttendance = .cup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == .cup {
            name.text = "壽山盃報名"
        } else {
            name.text = "球場活動報名"
        }
    }
    
    @IBAction func pressedSubmit(_ sender: Any) {
        
    }
}
