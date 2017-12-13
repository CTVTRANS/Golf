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

enum StatusWinings: Int {
    case winings = 1
    case notWining = 0
}

enum StatusReward: Int {
    case rewarded = 1
    case notRewarded = 0
}

enum ErrorMember: String {
    case passwordConfirmEmty = "密碼及再確認密碼不能空白"
    case confirmCodeEmty = "驗證碼不能空白"
    case numberPhoneEmty = "電話號碼不能空白"
    case nameEmty = "姓名不能空白"
    case passwordEmty = "密碼不能空白"
    case passwordHasSpace = "密碼不能有空格"
    case idCardEmty = "身份證字號不能空白"
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
            return "郵箱格式不對"
        case .passwordShort:
            return "密碼太短（一定要從8個符號以上）"
        case .confirmPassError:
            return "密碼及再確認密碼不重疊"
        case .passwordConfirmEmty:
            return "密碼及再確認密碼不能空白"
        case .passwordError:
            return "密碼嗎不對"
        case .numberPhoneError:
            return "電話號碼不對"
        case .confirmCodeError:
            return "驗證碼不對"
        case .confirmCodeEmty:
            return "驗證碼不能空白"
        case .numberPhoneEmty:
            return "電話號碼不能空白"
        case .nameEmty:
            return "姓名不能空白"
        case .passwordEmty:
            return "密碼不能空白"
        case .numberPhoneExists:
            return "手機號碼已經被註冊了"
        case .accountError:
            return "帳號不存在"
        }
    }
}

extension ErrorProduct {
    func decodeError() -> String {
        switch self {
        case .notFound:
            return "找不到產品"
        case .limited:
            return "每一天只能掃描一次"
        case .outOfTime:
            return "QRcode已經有人使用"
        case .noHasProduct:
            return "沒有產品"
        }
    }
}
