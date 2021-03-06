//
//  DiscountModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct DiscountModel: BaseModel {
    
    var idDiscount = 0
    var name = ""
    var imageURL = ""
    var price = 0
    
    static func decodeJSON(json: JSON) -> DiscountModel {
        return DiscountModel(idDiscount: json["id"].intValue,
                             name: json["title"].stringValue,
                             imageURL: json["image"].stringValue,
                             price: json["price"].intValue
        )
    }
}
