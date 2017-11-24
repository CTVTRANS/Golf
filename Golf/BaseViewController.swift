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
    var buttonMap = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    func setupNavigation() {
        buttonMap.setImage(#imageLiteral(resourceName: "ic_map"), for: .normal)
        buttonMap.addTarget(self, action: #selector(pressedMap), for: .touchUpInside)
        navigationItem.titleView = buttonMap
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_member"), style: .done, target: self, action: #selector(pressedMember))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home"), style: .done, target: self, action: #selector(pressedHome))
    }
    
    @objc func pressedMap() {
        print("map")
    }
    
    @objc func pressedMember() {
        if isAuthor {
            
        } else {
            if let vc = SinginViewController.instance() as? SinginViewController {
                navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    @objc func pressedHome() {
        navigationController?.popViewController(animated: false)
    }
}
