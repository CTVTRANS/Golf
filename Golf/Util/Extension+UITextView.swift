//
//  Extension+UITextView.swift
//  Golf
//
//  Created by le kien on 12/6/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    @IBInspectable var adjustFont: Bool {
        set {
            if newValue {
                let currentFont = self.font
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
