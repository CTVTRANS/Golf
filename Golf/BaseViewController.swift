//
//  BaseViewController.swift
//  Golf
//
//  Created by le kien on 11/20/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import Kingfisher
import LKExtension

func showLoading() {
    let viewLoading = LKActivity.showLoadingWithTitle(title: "Loading")
    UIApplication.shared.keyWindow?.addSubview(viewLoading)
}

func hideLoading() {
    DispatchQueue.main.async {
        let windown = UIApplication.shared.keyWindow
        let views = windown?.subviews
        for view in views! where view is LKActivity {
            view.removeFromSuperview()
        }
    }
}

class BaseViewController: UIViewController {

    var isAuthor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "ic_map"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_member"), style: .done, target: self, action: #selector(pressedMember))
        let homeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home"), style: .done, target: self, action: #selector(pressedHome))
        let backbutton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .done, target: self, action: #selector(pressedBack))
        navigationItem.leftBarButtonItems = [homeBarButton, backbutton]
    }
    
    func disableRightBarButton() {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func pressedMember() {
        if !isAuthor {
            if let vc = SinginViewController.instance() as? SinginViewController {
                navigationController?.pushViewController(vc, animated: false)
            }
        } else {
           
        }
    }
    
    @objc func pressedBack() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func pressedHome() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    func dataWithTask(_ task: APIRequest, onCompeted: @escaping BlookSuccess, onError: @escaping BlookFailure) {
        task.requestDataWith(onCompelete: { (data) in
            onCompeted(data)
        }) { (error) in
            hideLoading()
            UIAlertController.showAlertWith(title: "", message: error, in: self)
            onError(error)
        }
    }
    
    func checkMember() -> MemberModel? {
        let cahe = Cache<MemberModel>()
        guard let member = cahe.fetchObject() else {
            UIAlertController.showAlertWith(title: "", message: "you need sigin to attend", in: self, compeletionHandler: {
                if let vc = SinginViewController.instance() as? SinginViewController {
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            })
            return nil
        }
        MemberModel.shared = member
        return member
    }
}
