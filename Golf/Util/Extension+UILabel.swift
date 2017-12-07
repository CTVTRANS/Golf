//
//  Extension+UILabel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
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
                self.font = currentFont?.withSize(currentSize! * sizeScale)
            }
        }
        get {
            return false
        }
    }
    
    // MARK: create stroke for text in label
    func makeOutLineWidth(_ width: CGFloat, outLineColor: UIColor) {
        let strokeTextAttributes = [
            NSAttributedStringKey.strokeWidth: -1 * width,
            NSAttributedStringKey.strokeColor: outLineColor
            ] as [NSAttributedStringKey: Any]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }
}
