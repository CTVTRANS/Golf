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
    var listActivity = [Activity]()
    var description = ""
    
    static func decodeJSON(json: JSON) -> EventActivityModel {
        let array = getListActiviy(jsons: json[""].array!)
        return EventActivityModel(time: json[""].stringValue,
                                  address: json[""].stringValue,
                                  timeAttend: json[""].stringValue,
                                  priceAttend: json[""].intValue,
                                  listActivity: array,
                                  description: json[""].stringValue)
    }
    
    static func getListActiviy(jsons: [JSON]) -> [Activity] {
        var array = [Activity]()
        for json in jsons {
            array.append(Activity.decodeJSON(json: json))
        }
        return array
    }
    
}
