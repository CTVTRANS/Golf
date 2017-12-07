//
//  EventAvtivityModel.swift
//  Golf
//
//  Created by le kien on 12/1/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct EventActivityModel: BaseModel {
    
    var time = ""
    var address = ""
    var timeAttend = ""
    var priceAttend = 0
    var listActivity = ""
    var description = ""
    
    static func decodeJSON(json: JSON) -> EventActivityModel {
        let parseHTML = json["activity_schedule"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let listActivity = parseHTML.replacingOccurrences(of: " ", with: "\t", options: .regularExpression, range: nil)
        let description = json["attention"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return EventActivityModel(time: json["start_day"].stringValue,
                                  address: json["place"].stringValue,
                                  timeAttend: json["day_register"].stringValue,
                                  priceAttend: json["fee_register"].intValue,
                                  listActivity: listActivity,
                                  description: description)
    }
}
