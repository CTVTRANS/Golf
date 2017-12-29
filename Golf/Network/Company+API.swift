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
        typealias ResponseObject = CompanyModel
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return companyInfoURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> CompanyModel {
            let company = CompanyModel.decodeJSON(json: response)
            return company
        }
    }
    
    // webView
    struct GetInfoMatch: APIRequest {
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return compamyInfoMatch}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            var content = ""
            if let data = response["content"].string {
                content = data
            }
            return content
        }
    }
    
    struct GetListSponsor: APIRequest {
        
        var method: HTTPMethod {get {return .get}}
        var params: [String: Any] {get {return ["": ""]}}
        var path: String {get {return donorsImageURL}}
        
        func dataWithResponse(_ response: JSON) -> String {
            let imageURL = response["image"].stringValue
            return imageURL
        }
        typealias ResponseObject = String
    }
    
    struct DownloadImage: APIRequest {
        var url = ""
        init(urlString: String) {
            path = urlString
        }
        
        var method: HTTPMethod {get {return .get}}
        
        var params: [String: Any] {get {return ["": ""]}}
        
        var path: String {
            get {return url}
            set {url = newValue}
        }
        
        typealias ResponseObject = URL
        func dataWithResponse(_ response: JSON) -> URL {
            return URL(string: "s")!
        }
        
    }
}
