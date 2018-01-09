//
//  AttendanceViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class AttendanceViewController: BaseViewController, MainStoryBoard {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressAttendanceCup(_ sender: Any) {
        if let member = checkMember(), let vc = SubmitAttendanceViewController.instance() as? SubmitAttendanceViewController {
            vc.type = .cup
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedAttendanceTour(_ sender: Any) {
        if let member = checkMember(), let vc = SubmitAttendanceViewController.instance() as? SubmitAttendanceViewController {
            vc.type = .tour
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
