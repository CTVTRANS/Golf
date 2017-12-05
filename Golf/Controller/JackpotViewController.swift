//
//  JackpotViewController.swift
//  Golf
//
//  Created by le kien on 11/23/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class JackpotViewController: BaseViewController, SecondSroyBoard {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedScan(_ sender: Any) {
        if let member = checkMember(), let vc = QRScanViewController.instance() as? QRScanViewController {
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedListproduct(_ sender: Any) {
        if let member = checkMember(), let vc = ListJackpotViewController.instance() as? ListJackpotViewController {
            vc.statusProduct = .all
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedShowScaned(_ sender: Any) {
        if let member = checkMember(), let vc = ListJackpotViewController.instance() as? ListJackpotViewController {
            vc.statusProduct = .scaned
            vc.member = member
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
