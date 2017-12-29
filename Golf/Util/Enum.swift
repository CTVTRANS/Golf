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

enum ErrorCode: Int {
    case success = 200
    case passwordWrongFormat = 204
    case confirmPassWrong = 205
    case passwordEmty = 206
    case passwordWrong = 207
    case numberPhoneError = 208
    case confirmCodeError = 209
    case confirmCodeEmty = 210
    case numberPhoneEmty = 211
    case nameEmty = 212
    case numberPhoneExists = 214
    case accountError = 215
    case birthError = 217
    case idCardEmty = 218
    case addressEmty = 219
    case emailEmty = 220
    case emailError = 221
    case birthEmty = 222
    case emailExits = 223
    case idCardWrong = 224
    case passWordError = 605
    case idCardError = 606
    case memberRegisted = 607
}

enum ErrorProduct: Int {
    case notFound = 601
    case limited = 602
    case outOfTime = 603
    case noHasProduct = 604
    case notWining = 608
}

enum ErrorMessage: String {
    case pleaseFillFullInfo = "註冊會員全部項目為必填"
    case captchaWrong = "驗證碼錯誤"
    case newPassSent = "新密碼會寄到您的手機號碼的簡訊，請查看"
}

extension ErrorCode {
    func decodeError() -> String {
        switch self {
        case .success:
            return "成功"
        case .passwordWrongFormat:
            return "密碼格式請填入8-12碼英文+數字"
        case .confirmPassWrong:
            return "密碼及再輸入密碼不重疊"
        case .passwordEmty:
            return "密碼及再輸入密碼為必填"
        case .passwordWrong:
            return "密碼不對"
        case .numberPhoneError:
            return "帳號須為手機號碼"
        case .confirmCodeError:
            return "驗證碼錯誤"
        case .confirmCodeEmty:
            return "驗證碼為必填"
        case .numberPhoneEmty:
            return "聯絡電話為必填"
        case .nameEmty:
            return "姓名為必填"
        case .numberPhoneExists:
            return "此帳號已申請過"
        case .accountError:
            return "此帳號不存在"
        case .birthError:
            return "出生日格式錯誤"
        case .idCardEmty:
            return "身份證字號為必填"
        case .addressEmty:
            return "地址為必填"
        case .emailEmty:
            return "信箱為必填"
        case .emailError:
            return "信箱格式錯誤"
        case .birthEmty:
            return "出生日為必填"
        case .emailExits:
            return "此Email已申請過"
        case .idCardWrong:
            return "帳號或者身份證字號不對"
        case .passWordError:
            return "密碼至少要一英文+一數字 (不可全為英文或全數字)"
        case .idCardError:
            return "身分證格式錯誤"
        case .memberRegisted:
            return "您已報名過此活動 請等候專員連繫 感謝!"
        }
    }
}

extension ErrorProduct {
    func decodeError() -> String {
        switch self {
        case .notFound:
            return "此票劵不存在"
        case .limited:
            return "每一天只能掃描一次"
        case .outOfTime:
            return "此票劵已被掃描過"
        case .noHasProduct:
            return "沒有產品"
        case .notWining:
            return ""
        }
    }
}

extension StatusReward {
    func decodeError() -> String {
        switch self {
        case .notRewarded:
            return "未用"
        case .rewarded:
            return "已用"
        }
    }
}
