//
//  Extension+UIAlert.swift
//  Golf
//
//  Created by le kien on 12/4/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showAlertWith(title: String, message: String, in viewController: UIViewController) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWith(title: String, message: String, in viewController: UIViewController, compeletionHandler: @escaping () -> Void) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let accept = UIAlertAction(title: "OK", style: .default) { (_) in
            compeletionHandler()
        }
        alert.addAction(cancel)
        alert.addAction(accept)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showActionSheet(listTitle: [String], in viewController: UIViewController, compeletionHandler: @escaping (Int) -> Void ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for index in 0..<listTitle.count {
            let action = UIAlertAction(title: listTitle[index], style: .default, handler: { (_) in
                compeletionHandler(index)
            })
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
    }
}
