//
//  Company+Router.swift
//  Golf
//
//  Created by le kien on 12/4/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension CompanyModel {
    struct GetInfo: APIRequest {
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return companyInfoURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            let company = CompanyModel.decodeJSON(json: response)
            return company
        }
    }
    
    // webView
    struct GetInfoMatch: APIRequest {
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {get { return compamyInfoMatch}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            var content = ""
            if let data = response["content"].string {
                content = data
            }
            return content
        }
    }
}
