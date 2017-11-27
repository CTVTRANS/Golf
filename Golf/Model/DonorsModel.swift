//
//  DonorsModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DonorsModel: BaseModel {
    
    var idDonors = 0
    var name = ""
    var description = ""
    var year = 0
    
    static func decodeJSON(json: JSON) throws -> DonorsModel {
        return DonorsModel(idDonors: json[""].intValue,
                           name: json[""].stringValue,
                           description: json[""].stringValue,
                           year: json[""].intValue
        )
    }
}
