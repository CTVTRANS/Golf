//
//  Donor+Router.swift
//  Golf
//
//  Created by le kien on 12/5/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension DonorsModel {
    struct GetList: APIRequest {
        typealias ResponseObject = [DonorsModel]
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return donorsListURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> [DonorsModel] {
            var listDonors = [DonorsModel]()
            guard let jsons = response.array else {
                return listDonors
            }
            for json in jsons {
                let donors = DonorsModel.decodeJSON(json: json)
                listDonors.append(donors)
            }
            return listDonors
        }
    }
    
    struct GetCurrent: APIRequest {
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return donorsCurrentURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            let content = response["content"].stringValue
            return content
        }
    }
}
