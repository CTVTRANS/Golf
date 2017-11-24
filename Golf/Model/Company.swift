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
    var phone = 0
    var latitude = 0.0
    var lontitude = 0.0
    
    static func decodeJSON(json: JSON) throws -> CompanyModel {
        
        return CompanyModel(name: json[""].stringValue,
                            adress: json[""].stringValue,
                            website: json[""].stringValue,
                            phone: json[""].intValue,
                            latitude: json[""].doubleValue,
                            lontitude: json[""].doubleValue
        )
    }
}
