//
//  Member+Router.swift
//  Golf
//
//  Created by le kien on 12/4/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MemberSigin: BaseAPI {
    let userName: Int!
    let pass: String!
    
    init(userName: Int, pass: String) {
        self.userName = userName
        self.pass = pass
    }
    
    override func getPath() -> String { return memberSiginURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberSigup: BaseAPI {
    let userName: String!
    let pass: String!
    let confirmPass: String!
    let mobiPhone: Int!
    let birthDay: String?
    let idCard: Int!
    let adress: String?
    let email: String?
    let phone: Int?
    let code: String!
    
    init(userName: String, pass: String, confirmPass: String, mobile: Int, birthDay: String?, idCard: Int, address: String?, email: String?, phone: Int?, code: String) {
        self.userName = userName
        self.pass = pass
        self.confirmPass = confirmPass
        self.mobiPhone = mobile
        self.birthDay = birthDay
        self.idCard = idCard
        self.adress = address
        self.phone = phone
        self.email = email
        self.code = code
    }
    
    override func getPath() -> String { return memberSigupURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberForgotPass: BaseAPI {
    let userName: Int!
    let idCard: Int!
    let code: String!
    
    init(phone: Int, idCard: Int, code: String) {
        self.userName = phone
        self.idCard = idCard
        self.code = code
    }
    
    override func getPath() -> String { return memberForgotPassURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberUpdate: BaseAPI {

    let birthDay: String?
    let idCard: Int?
    let adress: String?
    let email: String?
    let phone: Int?
    
    init( birthDay: String?, idCard: Int?, address: String?, email: String?, phone: Int?) {
        self.birthDay = birthDay
        self.idCard = idCard
        self.adress = address
        self.phone = phone
        self.email = email
    }
    
    override func getPath() -> String { return memberUpdateInfoURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberScan: BaseAPI {
    let userName: String!
    let idCard: Int!
    let code: String!
    
    init(userName: String, idCard: Int, code: String) {
        self.userName = userName
        self.idCard = idCard
        self.code = code
    }
    
    override func getPath() -> String { return memberScanProductURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberAttend: BaseAPI {
    let idCard: Int!
    let type: TypeAttendance!
    
    init(idCard: Int, type: TypeAttendance) {
        self.idCard = idCard
        self.type = type
    }
    
    override func getPath() -> String { return memberAttendURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberGetCodeSms: BaseAPI {
    let idCard: Int!
    let phone: Int!
    
    init(idCard: Int, phone: Int) {
        self.idCard = idCard
        self.phone = phone
    }
    
    override func getPath() -> String { return memberGetCodeSms}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberGetTermOfUse: BaseAPI {
    override func getPath() -> String { return memberTermOfUse}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}
