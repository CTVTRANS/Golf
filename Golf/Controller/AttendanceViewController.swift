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
        if let member = checkMember(), let vc = SubmitAttendanceViewController.instance() as? SubmitAttendanceViewController {
            vc.type = .cup
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedAttendanceTour(_ sender: Any) {
        let member = MemberModel(idMember: 1, name: "kien", phone: "123", address: "asdf", email: "asdf", sex: 8, age: 34, birthDay: "sdf", idCard: "sdf", accessToken: "")
        let cache = Cache<MemberModel>()
        cache.save(object: member)
        if let member = checkMember(), let vc = SubmitAttendanceViewController.instance() as? SubmitAttendanceViewController {
            vc.type = .tour
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
