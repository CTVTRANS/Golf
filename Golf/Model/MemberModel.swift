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
    static let kIdMember = "idMember"
    static let kName = "name"
    static let kPhone = "phone"
    static let kAddress = "address"
    static let kEmail = "email"
    static let kSex = "sex"
    static let kAge = "age"
    static let kBirthDay = "birthDay"
    static let kIdCard = "idCard"
    
    var idMember = 0
    var name = ""
    var phone = ""
    var address = ""
    var email = ""
    var sex = 0
    var age = 0
    var birthDay = ""
    var idCard = ""
    
    static func decodeJSON(json: JSON) -> MemberModel {
        return MemberModel(idMember: json[""].intValue,
                           name: json[""].stringValue,
                           phone: json[""].stringValue,
                           address: json[""].stringValue,
                           email: json[""].stringValue,
                           sex: json[""].intValue,
                           age: json[""].intValue,
                           birthDay: json[""].stringValue,
                           idCard: json[""].stringValue
        )
    }
}

extension HeperMember: Encodable {
    var value: MemberModel? {
        return member
    }
}

extension MemberModel: Encoded {
    var encoder: HeperMember {
        return HeperMember(member: self)
    }
}

class HeperMember: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(member?.idMember, forKey: MemberModel.kIdMember)
        aCoder.encode(member?.name, forKey: MemberModel.kName)
        aCoder.encode(member?.phone, forKey: MemberModel.kPhone)
        aCoder.encode(member?.address, forKey: MemberModel.kAddress)
        aCoder.encode(member?.email, forKey: MemberModel.kEmail)
        aCoder.encode(member?.sex, forKey: MemberModel.kSex)
        aCoder.encode(member?.age, forKey: MemberModel.kAge)
        aCoder.encode(member?.birthDay, forKey: MemberModel.kBirthDay)
        aCoder.encode(member?.idCard, forKey: MemberModel.kIdCard)
    }
    
    var member: MemberModel?
    
    init(member: MemberModel) {
        self.member = member
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let idMember = aDecoder.decodeObject(forKey: MemberModel.kIdMember) as? Int,
            let name = aDecoder.decodeObject(forKey: MemberModel.kName) as? String,
            let phone = aDecoder.decodeObject(forKey: MemberModel.kPhone) as? String,
            let address = aDecoder.decodeObject(forKey: MemberModel.kAddress) as? String,
            let email = aDecoder.decodeObject(forKey: MemberModel.kEmail) as? String,
            let sex = aDecoder.decodeObject(forKey: MemberModel.kSex) as? Int,
            let age = aDecoder.decodeObject(forKey: MemberModel.kAge) as? Int,
            let birthDay = aDecoder.decodeObject(forKey: MemberModel.kBirthDay) as? String,
            let idCard = aDecoder.decodeObject(forKey: MemberModel.kIdCard) as? String else {
                member = nil
                super.init()
                return nil
        }
    
        member = MemberModel(idMember: idMember, name: name, phone: phone, address: address, email: email, sex: sex, age: age, birthDay: birthDay, idCard: idCard)
        super.init()
    }
}
