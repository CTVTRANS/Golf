//
//  ViewController.swift
//  Golf
//
//  Created by le kien on 11/20/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedAboutUs(_ sender: Any) {
        if let vc = AboutUsViewController.instance() as? AboutUsViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedContact(_ sender: Any) {
        if let vc = ContactUsViewController.instance() as? ContactUsViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func pressedEvent(_ sender: Any) {
        if let vc = EventViewController.instance() as? EventViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func pressedDiscount(_ sender: Any) {
        
    }
    
    @IBAction func pressedRegister(_ sender: Any) {
        
    }
    
    @IBAction func pressedJackpot(_ sender: Any) {
        
    }
}
