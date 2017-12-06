//
//  Extension+UIButton.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable var adjustFont: Bool {
        set {
            if newValue {
                let currentFont = self.titleLabel?.font
                let currentSize = currentFont?.pointSize
                var sizeScale: CGFloat = 1
                let device = UIDevice.current.modelName
                if device == "iPhone 5" {
                    sizeScale = 0.85
                }
                currentFont?.withSize(currentSize! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}
