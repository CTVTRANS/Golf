//
//  Extension+NSLayoutConstraint.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    @IBInspectable var adjustSize: Bool {
        set {
            if newValue {
                let currentConstant = self.constant
                var sizeScale: CGFloat = 1
                let device = UIDevice.current.modelName
                if device == "iPhone 5" {
                    sizeScale = 0.85
                }
                self.constant = currentConstant * sizeScale
            }
        }
        get {
            return false
        }
    }
}
