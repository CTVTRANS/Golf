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
    var listActivity = [ActivityModel]()
    var description = ""
    
    static func decodeJSON(json: JSON) -> EventActivityModel {
        var arrayActivity = [ActivityModel]()
        if let array = json["activity_schedule"].array {
            for arr in array {
                let activity = ActivityModel.decodeJSON(json: arr)
                arrayActivity.append(activity)
            }
        }
        let description = json["attention"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return EventActivityModel(time: json["start_day"].stringValue,
                                  address: json["place"].stringValue,
                                  timeAttend: json["day_register"].stringValue,
                                  priceAttend: json["fee_register"].intValue,
                                  listActivity: arrayActivity,
                                  description: description)
    }
}
