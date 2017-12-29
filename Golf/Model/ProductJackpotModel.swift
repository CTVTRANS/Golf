//
//  JackpotModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ProductJackpotModel: BaseModel {
    var idJackpit = 0
    var name = ""
    var imageURL = ""
    var amount = 0
    var productCode = ""
    var statusReward: StatusReward = .notRewarded
    var isWinings: StatusWinings = .notWining
    
    static func decodeJSON(json: JSON) -> ProductJackpotModel {
        let statusReward = StatusReward(rawValue: json["status_receive"].intValue)
        let isWinings = StatusWinings(rawValue: json["status_scan"].intValue)
        return ProductJackpotModel(idJackpit: json["id"].intValue,
                            name: json["title"].stringValue,
                            imageURL: json["image"].stringValue,
                            amount: json["amount_left"].intValue,
                            productCode: json["product_code"].stringValue,
                            statusReward: statusReward!,
                            isWinings: isWinings!
        )
    }
}
