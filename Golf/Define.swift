//
//  Define.swift
//  Golf
//
//  Created by le kien on 11/22/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

let widthScreen = UIScreen.main.bounds.width
let heightScreen = UIScreen.main.bounds.height

let companyEntity = "CompanyCore"
let donorsEntity = "DonorsCore"

let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
let apiMap = "AIzaSyBZ840yCSeH3DTwps5f9Aj031wawRcQP8k"  // key for google map
let apiDirection = "AIzaSyAm99Jv13nXVpPJOLSWaIDVCTMA1VTqilU"    //key for gooele direction

let baseRUL = "http://golf.transoftvietnam.com/api/"

let memberSiginURL = "member/login"
let memberSigupURL = "member/register"
let memberUpdateInfoURL = "member/update_profile"
let memberForgotPassURL = "member/forgot_password"
let memberScanProductURL = ""
let memberGetCodeSms = "member/generate_confirm_code"
let memberAttendURL = "event/attend"
let attendCup = "event/cup"
let attendTuor = "event/activity"

let companyInfoURL = "page/contact-us"
let compamyInfoMatch = "page/competition"

let productAllURL = "drawn/get_products"
let productDealURL = "discount/get_discount"
let productScanedURL = ""

let donorsListURL = "page/history-sponsors"
let donorsCurrentURL = "page/this-year-sponsors"

let holeDetailURL = "page/hole-golf"

let newsListURL = "page/news"

let eventInfo = "page/activity"

class Define: NSObject {

}
