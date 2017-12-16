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
        if let member = checkMember(), let vc = InfomationMemberController.instance() as? InfomationMemberController {
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
            return
        }
        if let vc = SinginViewController.instance() as? SinginViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func pressedBack() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func pressedHome() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    func dataWithTask<T: APIRequest>(_ task: T, onCompeted: @escaping BlookSuccess, onError: @escaping BlookFailure) {
        task.requestDataWith(onCompelete: { (data) in
            if let errorCode = data as? Int {
                if let errorMember = ErrorCode(rawValue: errorCode) {
                    let messageError = errorMember.decodeError()
                    UIAlertController.showAlertWith(title: "", message: messageError, in: self)
                    return
                }
                if let errorProduct = ErrorProduct(rawValue: errorCode) {
                    let messageError = errorProduct.decodeError()
                    onError(messageError)
                    return
                }
            }
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
            return nil
        }
        MemberModel.shared = member
        return member
    }
}
