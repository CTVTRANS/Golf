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
import CoreData

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
    let managerContext = StorageManager.shared.managedObjectContext
    let storage = StorageManager.shared
    var company: CompanyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        getImageCompany()
        imageView = UIImageView(frame: CGRect(x: (widthScreen - 120) / 2, y: heightScreen - 72, width: 120, height: 64))
        imageView?.contentMode = .scaleAspectFit
        if Contants.shared.data != nil {
            imageView?.image = UIImage(data: Contants.shared.data!)
        }
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
    fileprivate func getImageCompany() {
        let task = CompanyModel.GetInfo()
        dataWithTask(task, onCompeted: { (data) in
            guard let companyResponse = data as? CompanyModel else {
                return
            }
            self.company = companyResponse
            let task = CompanyModel.DownloadImage(urlString: companyResponse.footerImage)
            task.downloadDataWith(onCompelete: { (fileURL) in
                if let url = fileURL as? URL {
                    if let data = try? Data(contentsOf: url) {
                        Contants.shared.data = data
                        self.company?.footerFileUrl = url.path
                        self.saveCompany()
                    }
                }
            }, onError: { (_) in
                let urlString = self.fetchimageURL()
                if let url = URL(string: "file://\(urlString)") {
                    debugPrint(url)
                    if let data = try? Data(contentsOf: url) {
                        Contants.shared.data = data
                    }
                }
            })
            
        }) { (_) in
            let urlString = self.fetchimageURL()
            if let url = URL(string: "file://\(urlString)") {
                debugPrint(url)
                if let data = try? Data(contentsOf: url) {
                    Contants.shared.data = data
                }
            }
        }
    }
}

extension BaseViewController {
    func saveCompany() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                if result.first != nil, let companyResult = result.first {
                    companyResult.company = self.company!
                    self.storage.saveContext()
                    return
                }
                self.insertCompany(companyModel: self.company!)
            }
        } catch {
            print("Failed")
        }
    }
    
    func insertCompany(companyModel: CompanyModel) {
        let entity = NSEntityDescription.entity(forEntityName: companyEntity, in: self.managerContext)
        if let companyCore = NSManagedObject(entity: entity!, insertInto: managerContext) as? CompanyCore {
            companyCore.company = companyModel
        }
        storage.saveContext()
    }
    
    func fetchimageURL() -> String {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: companyEntity)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try self.managerContext.fetch(request) as? [CompanyCore] {
                guard let company = result.first?.company else {
                    hideLoading()
                    return ""
                }
                return company.footerFileUrl
            }
        } catch {
            print("Failed")
        }
        return ""
    }
}
