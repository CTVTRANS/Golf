//
//  Enum.swift
//  Golf
//
//  Created by le kien on 11/25/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation

enum TypeDonors {
    case older2018
    case thisYear
}

enum TypeJackpotProduct {
    case all // show all profuct
    case scaned // show all product was scaned
}

// Screen show event
enum TypeShow {
    case listMatch // show match of event
    case activity // show activity of event
    case company // show infimation company
}

enum TypeAttendance: Int {
    case cup = 0 // show screen attendance cup
    case tour = 1 // show screen attendance tour
}

enum TypeDiscount: Int {
    case tour = 0 // show all product discount
    case store = 1 // show product in store discount
}

enum TravelModes: Int {
    case driving
    case walking
    case bicycling
}

enum ErrorMember: String {
    case passwordConfirmEmty = "密码及重打密码不能空白"
    case confirmCodeEmty = "验证码不能空白"
    case numberPhoneEmty = "电话号码不能空白"
    case nameEmty = "名称不能空白"
    case passwordEmty = "密码不能空白"
    case passwordHasSpace = "密码不能有空格"
    case idCardEmty = "emty"
}

enum ErrorCode: Int {
    case success = 200
    case emailError = 201
    case passwordShort = 204
    case confirmPassError = 205
    case passwordConfirmEmty = 206
    case passwordError = 207
    case numberPhoneError = 208
    case confirmCodeError = 209
    case confirmCodeEmty = 210
    case numberPhoneEmty = 211
    case nameEmty = 212
    case passwordEmty = 213
    case numberPhoneExists = 214
    case accountError = 215
}

enum ErrorProduct: Int {
    case notFound = 601
    case limited = 602
    case outOfTime = 603
    case noHasProduct = 604
}

extension ErrorCode {
    func decodeError() -> String {
        switch self {
        case .success:
            return "成功！"
        case .emailError:
            return "邮箱格式不对"
        case .passwordShort:
            return "密码太短（一定要从8个符号以上）"
        case .confirmPassError:
            return "密码及重打密码不重叠"
        case .passwordConfirmEmty:
            return "密码及重打密码不能空白"
        case .passwordError:
            return "密码吗不对"
        case .numberPhoneError:
            return "电话号码不对"
        case .confirmCodeError:
            return "验证码不对"
        case .confirmCodeEmty:
            return "验证码不能空白"
        case .numberPhoneEmty:
            return "电话号码不能空白"
        case .nameEmty:
            return "名称不能空白"
        case .passwordEmty:
            return "密码不能空白"
        case .numberPhoneExists:
            return "手机号码已经被注册了"
        case .accountError:
            return "帐号不存在"
        }
    }
}

extension ErrorProduct {
    func decodeError() -> String {
        switch self {
        case .notFound:
            return "not foud product"
        case .limited:
            return "limited scand"
        case .outOfTime:
            return "out of time"
        case .noHasProduct:
            return "ho has product"
        }
    }
}
