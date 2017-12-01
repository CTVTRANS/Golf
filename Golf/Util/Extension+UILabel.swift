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
    
    // MARK: create stroke for text in label
    func makeOutLineWidth(_ width: CGFloat, outLineColor: UIColor) {
        let strokeTextAttributes = [
            NSAttributedStringKey.strokeWidth: -1 * width,
            NSAttributedStringKey.strokeColor: outLineColor
            ] as [NSAttributedStringKey: Any]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }
}
