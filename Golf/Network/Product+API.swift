//
//  Product+Router.swift
//  Golf
//
//  Created by le kien on 12/5/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension JackpotModel {
    struct GetAll: APIRequest {
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return productAllURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct GetProductDeal: APIRequest {
        let type: TypeDiscount!
        init(type: TypeDiscount) {
            self.type = type
        }
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return productDealURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
    
    struct GetProductScaned: APIRequest {
        let idCard: String!
        let type: TypeJackpotProduct!
        init(idCard: String, type: TypeJackpotProduct) {
            self.idCard = idCard
            self.type = type
        }
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return productScanedURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> Any {
            return response
        }
    }
}
