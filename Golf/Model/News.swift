//
//  News.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NewsModel: BaseModel {
    
    var content = ""
    
    static func decodeJSON(json: JSON) throws -> NewsModel {
        return NewsModel(content: json[""].stringValue)
    }
}
