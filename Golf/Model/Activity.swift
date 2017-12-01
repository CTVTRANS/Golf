//
//  File.swift
//  Golf
//
//  Created by le kien on 12/1/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Activity: BaseModel {
    var time = ""
    var content = ""
    
    static func decodeJSON(json: JSON) -> Activity {
        return Activity(time: json[""].stringValue, content: json[""].stringValue)
    }
}
