//
//  Map.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MapModel: BaseModel {
    
    var content = ""
    
    static func decodeJSON(json: JSON) throws -> MapModel {
        return MapModel(content: json[""].stringValue)
    }
}
