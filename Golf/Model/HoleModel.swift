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
    var par = 1
    var regularWhite = 1
    var regularRed = 1
    var content = ""
    var imageBusiness = ""
    
    static func decodeJSON(json: JSON) -> HoleModel {
        return HoleModel(index: json["hole"].intValue,
                         par: json["par"].intValue,
                         regularWhite: json["regular_white"].intValue,
                         regularRed: json["regular_red"].intValue,
                         content: json["content"].stringValue,
                         imageBusiness: json["hole_sponsor"].stringValue
        )
    }
}
