//
//  Company.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CompanyModel: BaseModel {
    
    var name = ""
    var adress = ""
    var website = ""
    var phone = ""
    var latitude = 21.0062876
    var lontitude = 105.8423921
    var info = ""
    
    static func decodeJSON(json: JSON) -> CompanyModel {
        return CompanyModel(name: json[""].stringValue,
                            adress: json[""].stringValue,
                            website: json[""].stringValue,
                            phone: json[""].stringValue,
                            latitude: json[""].doubleValue,
                            lontitude: json[""].doubleValue,
                            info: json[""].stringValue
        )
    }
}
