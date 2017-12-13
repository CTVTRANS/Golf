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
        let date = Date.convertDateString(date: dateView.date)
        self.hide()
        callBackDate(date)
    }
}

extension Date {
    static func convertDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateSting = dateFormatter.string(from: date)
        return dateSting
    }
}
