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

enum TypeAttendance {
    case cup // show screen attendance cup
    case tour // show screen attendance tour
}

enum TypeDiscount: Int {
    case product // show all product discount
    case store // show product in store discount
}

enum TravelModes: Int {
    case driving
    case walking
    case bicycling
}
