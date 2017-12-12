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
    static let kLandLine = "landLine"
    static let kBirthDay = "birthDay"
    static let kIdCard = "idCard"
    static let kAccessToken = "accessToken"
    
    var idMember = 0
    var name = ""
    var phone = ""
    var address = ""
    var email = ""
    var landLine = ""
    var birthDay = ""
    var idCard = ""
    var accessToken = ""
    
    static var shared = MemberModel()
    
    static func decodeJSON(json: JSON) -> MemberModel {
        return MemberModel(idMember: json["id"].intValue,
                           name: json["name"].stringValue,
                           phone: String(json["phone_number"].intValue),
                           address: json["address"].stringValue,
                           email: json["email"].stringValue,
                           landLine: json["landline_telephone"].stringValue,
                           birthDay: json["date_of_birth"].stringValue,
                           idCard: json["identity_card_number"].stringValue,
                           accessToken: json["access_token"].stringValue
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
        aCoder.encode(member?.landLine, forKey: MemberModel.kLandLine)
        aCoder.encode(member?.birthDay, forKey: MemberModel.kBirthDay)
        aCoder.encode(member?.idCard, forKey: MemberModel.kIdCard)
        aCoder.encode(member?.accessToken, forKey: MemberModel.kAccessToken)
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
            let landLine = aDecoder.decodeObject(forKey: MemberModel.kLandLine) as? String,
            let birthDay = aDecoder.decodeObject(forKey: MemberModel.kBirthDay) as? String,
            let idCard = aDecoder.decodeObject(forKey: MemberModel.kIdCard) as? String,
            let accessToken = aDecoder.decodeObject(forKey: MemberModel.kAccessToken) as? String else {
                member = nil
                super.init()
                return nil
        }
    
        member = MemberModel(idMember: idMember, name: name, phone: phone, address: address, email: email, landLine: landLine, birthDay: birthDay, idCard: idCard, accessToken: accessToken)
        super.init()
    }
}
