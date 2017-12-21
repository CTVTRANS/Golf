//
//  ChooseBirthDayView.swift
//  Golf
//
//  Created by le kien on 12/13/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class ChooseBirthDayView: BaseDailog {

    @IBOutlet weak var dateView: UIDatePicker!
    var callBackDate:((_ data: String) -> Void) = {_ in}
    
    @IBAction func pressedChose(_ sender: Any) {
        let date = Date.convert(date: dateView.date, toString: "yyy-MM-dd")
        self.hide()
        callBackDate(date)
    }
}
