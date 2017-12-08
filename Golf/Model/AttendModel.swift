//
//  ContentAttendModel.swift
//  Golf
//
//  Created by le kien on 12/7/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AttendModel: BaseModel {
    var idEvent = 0
    var title = ""
    var content = ""
    static func decodeJSON(json: JSON) -> AttendModel {
        return AttendModel(idEvent: json["id"].intValue,
                           title: json["title"].stringValue,
                           content: json["content"].stringValue
        )
    }
}
