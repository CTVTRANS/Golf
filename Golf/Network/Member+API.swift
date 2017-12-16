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

extension MemberModel {
    struct Sigin: APIRequest {
        typealias ResponseObject = MemberModel
        let phone: Int!
        let pass: String!
        init(phone: Int, pass: String) {
            self.phone = phone
            self.pass = pass
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["phone_number": phone, "password": pass]}}
        var path: String {
            get { return memberSiginURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> MemberModel {
            let member = MemberModel.decodeJSON(json: response)
            return member
        }
    }
    
    struct Sigup: APIRequest {
        typealias ResponseObject = MemberModel
        let userName: String!
        let pass: String!
        let confirmPass: String!
        let mobiPhone: Int!
        let birthDay: String!
        let idCard: String!
        let adress: String!
        let email: String!
        let landLine: String!
        let code: String!
        init(userName: String, pass: String, confirmPass: String, mobile: Int, birthDay: String?, idCard: String, address: String?, email: String?, landLine: String?, code: String) {
            self.userName = userName
            self.pass = pass
            self.confirmPass = confirmPass
            self.mobiPhone = mobile
            self.birthDay = birthDay
            self.idCard = idCard
            self.adress = address
            self.email = email
            self.landLine = landLine
            self.code = code
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["phone_number": mobiPhone,
                                                 "confirm_code": code,
                                                 "name": userName,
                                                 "email": email,
                                                 "landline_telephone": landLine,
                                                 "birthday": birthDay,
                                                 "identity_card_number": idCard,
                                                 "address": adress,
                                                 "password": pass,
                                                 "confirm_password": confirmPass]}}
        var path: String {
            get { return memberSigupURL}
            set {}
        }
    
        func dataWithResponse(_ response: JSON) -> MemberModel {
            let member = MemberModel.decodeJSON(json: response)
            return member
        }
    }
    
    struct ForgotPass: APIRequest {
        let phone: Int!
        let idCard: String!
        init(phone: Int, idCard: String) {
            self.phone = phone
            self.idCard = idCard
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["phone_number": phone, "identity_card_number": idCard]}}
        var path: String {
            get { return memberForgotPassURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct ChangePass: APIRequest {
        let oldPass: String!
        let newPass: String!
        let confirmPass: String!
        init(oldPass: String, newPass: String, confirmPass: String) {
            self.oldPass = oldPass
            self.newPass = newPass
            self.confirmPass = confirmPass
        }
        var method: HTTPMethod {get {return .post}}
        var params: [String: Any] {get {return ["access_token": MemberModel.shared.accessToken,
                                                 "member_id": MemberModel.shared.idMember,
                                                 "old_password": oldPass,
                                                 "new_password": newPass,
                                                 "confirm_password": confirmPass]}}
        var path: String {get {return memberChangePass}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            let newtoken = response["new_access_token"].stringValue
            return newtoken
        }
    }
    
    struct Update: APIRequest {
        let name: String!
        let birthDay: String!
        let idCard: String!
        let adress: String!
        let emailMember: String!
        let landLine: String!
        
        init(name: String?, birthDay: String!, idCard: String?, address: String!, email: String!, landLine: String!) {
            self.name = name
            self.birthDay = birthDay
            self.idCard = idCard
            self.adress = address
            self.emailMember = email
            self.landLine = landLine
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["member_id": MemberModel.shared.idMember,
                                                 "access_token": MemberModel.shared.accessToken,
                                                 "name": name,
                                                 "birthday": birthDay,
                                                 "identity_card_number": idCard,
                                                 "address": adress,
                                                 "landline_telephone": landLine,
                                                 "email": emailMember]}}
        var path: String {
            get { return memberUpdateInfoURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct ScanProduct: APIRequest {
        typealias ResponseObject = JackpotModel
        let code: String!
        init(code: String) {
            self.code = code
        }
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["product_code": code,
                                                 "member_id": MemberModel.shared.idMember,
                                                 "access_token": MemberModel.shared.accessToken]}}
        var path: String {
            get { return memberScanProductURL}
            set {}
        }
        func dataWithResponse(_ response: JSON) -> JackpotModel {
            let product = JackpotModel.decodeJSON(json: response)
            return product
        }
    }
    
    struct Attend: APIRequest {
        private let eventID: Int!
        private let memberID = MemberModel.shared.idMember
        private let accessToken = MemberModel.shared.accessToken
        
        init(eventID: Int) {
            self.eventID = eventID
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["event_id": eventID, "member_id": memberID, "access_token": accessToken]}}
        var path: String {
            get { return memberAttendURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct GetCodeSms: APIRequest {
        let phone: Int!
        init(phone: Int) {
            self.phone = phone
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["phone_number": phone]}}
        var path: String {
            get { return memberGetCodeSms}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct GetTermOfUse: APIRequest {
        typealias ResponseObject = AttendModel
        var pathURL = ""
        init(type: TypeAttendance) {
            switch type {
            case .cup:
                path = attendCup
            case .tour:
                path = attendTuor
            }
        }
        
        var method: HTTPMethod {get {return .get}}
        var params: [String: Any] {get {return ["": ""]}}
        var path: String {
            get {return pathURL}
            set {pathURL = newValue}
        }
        
        func dataWithResponse(_ response: JSON) -> AttendModel {
            let attend = AttendModel.decodeJSON(json: response)
            return attend
        }
    }
}
