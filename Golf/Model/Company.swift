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
//    var listDonors = [DonorsModel]()
    
    static func decodeJSON(json: JSON) -> CompanyModel {
        return CompanyModel(name: json[""].stringValue,
                            adress: json[""].stringValue,
                            website: json[""].stringValue,
                            phone: json[""].stringValue,
                            latitude: json[""].doubleValue,
                            lontitude: json[""].doubleValue,
                            info: json[""].stringValue
        )
    }
}

class CompanyCoreData: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var website: String
    @NSManaged var phone: String
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var info: String

    var company: CompanyModel {
        get {
            return CompanyModel(name: self.name, adress: self.address, website: self.website, phone: self.phone, latitude: self.lat, lontitude: self.lon, info: self.info)
        }
        set {
            self.name = newValue.name
            self.address = newValue.adress
            self.website = newValue.website
            self.phone = newValue.phone
            self.lat = newValue.latitude
            self.lon = newValue.lontitude
            self.info = newValue.info
        }
    }
}
