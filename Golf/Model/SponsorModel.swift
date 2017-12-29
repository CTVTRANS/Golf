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

struct SponsorModel: BaseModel {
    
    var idDonors = 0
    var name = ""
    var description = ""
    var year = 0
    
    static func decodeJSON(json: JSON) -> SponsorModel {
        let name = json["title"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let description = json["description"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return SponsorModel(idDonors: json[""].intValue,
                           name: name,
                           description: description,
                           year: json["year"].intValue
        )
    }
}

extension HeperSponsor: Encodable {
    var value: SponsorModel? {
        return sponsor
    }
}

extension SponsorModel: Encoded {
    var encoder: HeperSponsor {
        return HeperSponsor(sponsor: self)
    }
}

class HeperSponsor: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sponsor?.idDonors, forKey: "idDonors")
        aCoder.encode(sponsor?.name, forKey: "name")
        aCoder.encode(sponsor?.description, forKey: "description")
        aCoder.encode(sponsor?.year, forKey: "year")
    }
    
    var sponsor: SponsorModel?
    
    init(sponsor: SponsorModel) {
        self.sponsor = sponsor
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let idDonors = aDecoder.decodeObject(forKey: "idDonors") as? Int,
            let name = aDecoder.decodeObject(forKey: "name") as? String,
            let description = aDecoder.decodeObject(forKey: "description") as? String,
            let year = aDecoder.decodeObject(forKey: "year") as? Int else {
                sponsor = nil
                super.init()
                return nil
        }
        
        sponsor = SponsorModel(idDonors: idDonors, name: name, description: description, year: year)
        super.init()
    }
}

extension SponsorsCore {
    var sponsors: SponsorModel {
        get {
            return SponsorModel(idDonors: Int(self.id), name: self.name!, description: self.detail!, year: Int(self.year))
        }
        set {
            self.id = Int16(newValue.idDonors)
            self.name = newValue.name
            self.detail = newValue.description
            self.year = Int16(newValue.year)
        }
    }
}
