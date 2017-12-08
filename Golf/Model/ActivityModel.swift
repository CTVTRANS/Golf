//
//  ActivityModel.swift
//  Golf
//
//  Created by le kien on 12/7/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ActivityModel: BaseModel {
    
    var time = ""
    var content = ""
    
    static func decodeJSON(json: JSON) -> ActivityModel {
        return ActivityModel(time: json["time"].stringValue,
                             content: json["content"].stringValue)
    }
}
