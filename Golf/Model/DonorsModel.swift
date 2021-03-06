//
//  DonorsModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct DonorsModel: BaseModel {
    
    var idDonors = 0
    var name = ""
    var description = ""
    var year = 0
    
    static func decodeJSON(json: JSON) -> DonorsModel {
        let name = json["title"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let description = json["description"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return DonorsModel(idDonors: json[""].intValue,
                           name: name,
                           description: description,
                           year: json["year"].intValue
        )
    }
}

extension DonorsCore {
    var donors: DonorsModel {
        get {
            return DonorsModel(idDonors: Int(self.id), name: self.name!, description: self.detail!, year: Int(self.year))
        }
        set {
            self.id = Int16(newValue.idDonors)
            self.name = newValue.name
            self.detail = newValue.description
            self.year = Int16(newValue.year)
        }
    }
}
