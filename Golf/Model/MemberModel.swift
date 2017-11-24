//
//  MemberModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MemberModel: BaseModel {
    var idMember = 0
    var name = ""
    var phone = 0
    var email = ""
    var sex = 0
    var age = 0
    var birthDay = ""
    var idCard = 0
    
    static func decodeJSON(json: JSON) throws -> MemberModel {
        return MemberModel(idMember: json[""].intValue,
                           name: json[""].stringValue,
                           phone: json[""].intValue,
                           email: json[""].stringValue,
                           sex: json[""].intValue,
                           age: json[""].intValue,
                           birthDay: json[""].stringValue,
                           idCard: json[""].intValue
        )
    }
}
