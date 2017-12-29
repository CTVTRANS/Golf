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
import SystemConfiguration

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
    
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        getImageCompany()
        imageView = UIImageView(frame: CGRect(x: (widthScreen - 120) / 2, y: heightScreen - 72, width: 120, height: 64))
        imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(imageView!)
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
                    hideLoading()
                    UIAlertController.showAlertWith(title: "", message: messageError, in: self)
                    onError(messageError)
                }
                if let errorProduct = ErrorProduct(rawValue: errorCode) {
                    hideLoading()
                    let messageError = errorProduct.decodeError()
                    if errorProduct == .outOfTime {
                         onError(errorCode.description)
                        return
                    }
                    onError(messageError)
                }
                return
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
    
    // MARK: API request
    private func getImageCompany() {
        let task = CompanyModel.GetInfo()
        dataWithTask(task, onCompeted: { (data) in
            guard let companyResponse = data as? CompanyModel else {
                return
            }
            let task = CompanyModel.DownloadImage(urlString: companyResponse.footerImage)
            task.downloadDataWith(onCompelete: { (fileURL) in
                if let url = fileURL as? URL {
                    if let data = try? Data(contentsOf: url) {
                       self.imageView?.image = UIImage(data: data)
                    }
                }
            }, onError: { (_) in
                
            })
            
        }) { (_) in
            
        }
    }
}

extension BaseViewController {
//    func downloadWithTask<T: APIRequest>(_ task: T, onCompeted: @escaping BlookSuccess, onError: @escaping BlookFailure) {
//        task.downloadDataWith(onCompelete: { (data) in
//            debugPrint(data)
//        }) { (_) in
//
//        }
//    }
}
