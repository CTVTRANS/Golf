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
    let userName: String!
    let pass: String!
    
    init(userName: String, pass: String) {
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
    let mobiPhone: String!
    let birthDay: String!
    let idCard: Int!
    let adress: String!
    let email: String!
    let phone: Int!
    let code: String!
    
    init(userName: String, pass: String, confirmPass: String, modile: String, birthDay: String, idCard: Int, address: String, email: String, phone: Int, code: String) {
        self.userName = userName
        self.pass = pass
        self.confirmPass = confirmPass
        self.mobiPhone = modile
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
    let userName: String!
    let idCard: Int!
    let code: String!
    
    init(userName: String, idCard: Int, code: String) {
        self.userName = userName
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
    let mobiPhone: String!
    let birthDay: String!
    let idCard: Int!
    let adress: String!
    let email: String!
    let phone: Int!
    let code: String!
    
    init(modile: String, birthDay: String, idCard: Int, address: String, email: String, phone: Int, code: String) {
        self.mobiPhone = modile
        self.birthDay = birthDay
        self.idCard = idCard
        self.adress = address
        self.phone = phone
        self.email = email
        self.code = code
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
    
    override func getPath() -> String { return memberAttend}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class MemberGetProduct: BaseAPI {
    let idCard: Int!
    let type: TypeJackpotProduct!
    
    init(idCard: Int, type: TypeJackpotProduct) {
        self.idCard = idCard
        self.type = type
    }
    
    override func getPath() -> String { return memberGetProductURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}
