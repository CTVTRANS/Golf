//
//  HoleModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HoleModel: BaseModel {
    
    var index = 1
    var content = ""
    
    static func decodeJSON(json: JSON) -> HoleModel {
        return HoleModel(index: json[""].intValue,
                         content: json[""].stringValue)
    }
}
