//
//  AttendanceViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class AttendanceViewController: BaseViewController, MainStoryBoard {

    var member: MemberModel?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressAttendanceCup(_ sender: Any) {
        let member = self.member?.idMember
        guard member != 0, member != nil else {
            debugPrint("need sigin")
            return
        }
        if let vc = SubmitAttendanceViewController.instance() as? SubmitAttendanceViewController {
            vc.type = .cup
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedAttendanceTour(_ sender: Any) {
        if let vc = SubmitAttendanceViewController.instance() as? SubmitAttendanceViewController {
            vc.type = .tour
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
