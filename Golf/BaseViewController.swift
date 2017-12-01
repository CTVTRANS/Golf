//
//  BaseViewController.swift
//  Golf
//
//  Created by le kien on 11/20/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    @objc func pressedMember() {
        isAuthor = !isAuthor
        if isAuthor {
            if let vc = ForgotPassViewController.instance() as? ForgotPassViewController {
                navigationController?.pushViewController(vc, animated: false)
            }
        } else {
            if let vc = SinginViewController.instance() as? SinginViewController {
                navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    @objc func pressedBack() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func pressedHome() {
        navigationController?.popToRootViewController(animated: false)
    }
}
