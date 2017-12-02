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
    var numberHole = 0
    var name = ""
    var imageURL = ""
    var amount = 0
    var status = false
    
    static func decodeJSON(json: JSON) -> JackpotModel {
        return JackpotModel(idJackpit: json[""].intValue,
                            numberHole: json[""].intValue,
                            name: json[""].stringValue,
                            imageURL: json[""].stringValue,
                            amount: json[""].intValue,
                            status: json[""].boolValue
        )
    }
}
