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
    
    var titleNews = ""
    var content = ""
    
    static func decodeJSON(json: JSON) -> NewsModel {
        return NewsModel(titleNews: json["title"].stringValue, content: json["content"].stringValue)
    }
}
