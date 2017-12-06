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
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return donorsListURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            var listDonors = [DonorsModel]()
            guard let jsons = response.array else {
                return response
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
        var path: String {get { return donorsCurrentURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            let content = response["content"].stringValue
            return content
        }
    }
}
