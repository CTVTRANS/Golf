//
//  SubmitAttendanceViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class SubmitAttendanceViewController: BaseViewController, MainStoryBoard {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var idUser: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var spaceTopButton: NSLayoutConstraint!
    
    @IBOutlet weak var submitButton: UIButton!
    var type: TypeAttendance = .cup
    var member: MemberModel!
    var isshowMember = true
    private var attend: AttendModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webView.delegate = self
        spaceTopButton.constant = 16
        memberView.isHidden = true
        loadMember()
        getContent()
    }
    
    func loadMember() {
        email.text = member.email
        idUser.text = member.idCard
        nameUser.text = member.name
    }
    
    func getContent() {
        let task = MemberModel.GetTermOfUse(type: type)
        dataWithTask(task, onCompeted: { (data) in
            if let attend = data as? AttendModel {
                self.attend = attend
                self.titleView.text = attend.title
                self.webView.loadHTMLString((self.attend?.content)!, baseURL: nil)
            }
        }) { (_) in
            
        }
    }
    
    func attendAction() {
        let task = MemberModel.Attend(eventID: (attend?.idEvent)!)
        dataWithTask(task, onCompeted: { (_) in
            
        }) { (_) in
            
        }
    }
    
    @IBAction func pressedSubmit(_ sender: Any) {
        if isshowMember {
            spaceTopButton.constant = memberView.frame.size.height + 16
            submitButton.setTitle(" 確認資料並報名活動 ", for: .normal)
            memberView.isHidden = false
            isshowMember = false
            return
        }
        attendAction()
        if let vc = AttendSuccessViewController.instance() as? AttendSuccessViewController {
            vc.titleName = self.attend?.title
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension SubmitAttendanceViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}
