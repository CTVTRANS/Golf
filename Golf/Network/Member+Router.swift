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
        let userName: Int!
        let pass: String!
        init(userName: Int, pass: String) {
            self.userName = userName
            self.pass = pass
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberSiginURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct Sigup: APIRequest {
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
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberSigupURL}}
    
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct ForgotPass: APIRequest {
        let userName: Int!
        let idCard: Int!
        let code: String!
        init(phone: Int, idCard: Int, code: String) {
            self.userName = phone
            self.idCard = idCard
            self.code = code
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberForgotPassURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct Update: APIRequest {
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
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberUpdateInfoURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct ScanProduct: APIRequest {
        let userName: String!
        let idCard: Int!
        let code: String!
        init(userName: String, idCard: Int, code: String) {
            self.userName = userName
            self.idCard = idCard
            self.code = code
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberScanProductURL}}
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct Attend: APIRequest {
        let idCard: Int!
        let type: TypeAttendance!
        init(idCard: Int, type: TypeAttendance) {
            self.idCard = idCard
            self.type = type
        }
        var method: HTTPMethod {get { return .post}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberAttendURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct GetCodeSms: APIRequest {
        let idCard: Int!
        let phone: Int!
        init(idCard: Int, phone: Int) {
            self.idCard = idCard
            self.phone = phone
        }
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberGetCodeSms}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct GetTermOfUse: APIRequest {
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return memberTermOfUse}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
}
