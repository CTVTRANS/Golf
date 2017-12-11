//
//  DiscountViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class DiscountViewController: BaseViewController, SecondSroyBoard {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressedDiscountProduct(_ sender: Any) {
        if let vc = ListDiscountViewController.instance() as? ListDiscountViewController {
            vc.typeDiscount = .tour
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedDisCountStore(_ sender: Any) {
        if let vc = ListDiscountViewController.instance() as? ListDiscountViewController {
            vc.typeDiscount = .store
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
