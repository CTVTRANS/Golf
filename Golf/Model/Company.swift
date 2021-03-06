//
//  Company.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

struct CompanyModel: BaseModel {
    
    var name = ""
    var adress = ""
    var website = ""
    var phone = ""
    var latitude = 21.0062876
    var lontitude = 105.8423921
    var info = ""
    var mapInfo = ""
    var currentDonor = ""
    
    static func decodeJSON(json: JSON) -> CompanyModel {
        return CompanyModel(name: json[""].stringValue,
                            adress: json["contact_us"]["address"].stringValue,
                            website: json["contact_us"]["website"].stringValue,
                            phone: json["contact_us"]["phone_number"].stringValue,
                            latitude: json["map"]["latitude"].doubleValue,
                            lontitude: json["map"]["longitude"].doubleValue,
                            info: json["about_us"].stringValue,
                            mapInfo: json[""].stringValue,
                            currentDonor: json[""].stringValue
        )
    }
}

extension CompanyCore {
    var company: CompanyModel {
        get {
            return CompanyModel(name: self.name!, adress: self.address!, website: self.website!, phone: self.phone!, latitude: self.lat, lontitude: self.lon, info: self.info!, mapInfo: self.mapInfo!, currentDonor: self.currentDonor!)
        }
        set {
            self.name = newValue.name
            self.address = newValue.adress
            self.website = newValue.website
            self.phone = newValue.phone
            self.lat = newValue.latitude
            self.lon = newValue.lontitude
            self.info = newValue.info
            self.mapInfo = newValue.mapInfo
            self.currentDonor = newValue.currentDonor
        }
    }
}
