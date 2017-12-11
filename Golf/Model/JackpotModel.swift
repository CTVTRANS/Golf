//
//  JackpotModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct JackpotModel: BaseModel {
    var idJackpit = 0
    var name = ""
    var imageURL = ""
    var amount = 0
    var productCode = ""
    var statusReceive = 0
    var isWinings = 0
    
    static func decodeJSON(json: JSON) -> JackpotModel {
        return JackpotModel(idJackpit: json["id"].intValue,
                            name: json["title"].stringValue,
                            imageURL: json["image"].stringValue,
                            amount: json["amount_left"].intValue,
                            productCode: json["product_code"].stringValue,
                            statusReceive: json["status_receive"].intValue,
                            isWinings: json["status_scan"].intValue
        )
    }
}
