//
//  SubmitAttendanceViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class SubmitAttendanceViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var idUser: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var spaceTopButton: NSLayoutConstraint!
    
    var type: TypeAttendance = .cup
    var member: MemberModel!
    var isshowMember = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        spaceTopButton.constant = 16
        memberView.isHidden = true
        if type == .cup {
            name.text = "2018壽山盃報名"
        } else {
            name.text = "2018球場活動報名"
        }
        loadMember()
        getContent()
    }
    
    func loadMember() {
        email.text = member.email
        idUser.text = member.idCard
        nameUser.text = member.name
    }
    
    func getContent() {
        let task = MemberGetTermOfUse()
        dataWithTask(task, onCompeted: { (data) in
            if let content = data as? String {
                 self.webView.loadHTMLString(content, baseURL: nil)
            }
        }) { (_) in
            
        }
    }
    
    @IBAction func pressedSubmit(_ sender: Any) {
        if isshowMember {
            spaceTopButton.constant = memberView.frame.size.height + 16
            memberView.isHidden = false
            isshowMember = false
            return
        }
        if let vc = AttendSuccessViewController.instance() as? AttendSuccessViewController {
            if type == .cup {
                vc.titleName = "2018壽山盃報名"
            } else {
                vc.titleName = "2018球場活動報名"
            }
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension SubmitAttendanceViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
