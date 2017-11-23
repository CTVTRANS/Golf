//
//  EventViewController.swift
//  Golf
//
//  Created by le kien on 11/21/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController, MainStoryBoard {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func pressedShowHold(_ sender: Any) {
        if let vc = HoleListViewController.instance() as? HoleListViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func pressedShowMath(_ sender: Any) {
        if let vc = ListInfotmatchViewController.instance() as? ListInfotmatchViewController {
            vc.typeShow = .listMatch
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func pressedShowEvent(_ sender: Any) {
        // Change content for webview
        if let vc = ListInfotmatchViewController.instance() as? ListInfotmatchViewController {
            vc.typeShow = .activity
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBAction func pressedShowCompany(_ sender: Any) {
        // Change background, hiddien webview
        if let vc = ListInfotmatchViewController.instance() as? ListInfotmatchViewController {
            vc.typeShow = .company
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }
}
