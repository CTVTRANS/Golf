//
//  AboutUsViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController, MainStoryBoard {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedShowOldDonores(_ sender: Any) {
        if let vc = DonorsViewController.instance() as? DonorsViewController {
            vc.type = .older2018
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func pressedShowNewDonors(_ sender: Any) {
        if let vc = DonorsViewController.instance() as? DonorsViewController {
            vc.type = .thisYear
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
