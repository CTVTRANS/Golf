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
        typealias ResponseObject = [JackpotModel]
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return productAllURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> [JackpotModel] {
            var listJackpotModel = [JackpotModel]()
            guard let jsons = response.array else {
                return listJackpotModel
            }
            for json in jsons {
                let product = JackpotModel.decodeJSON(json: json)
                listJackpotModel.append(product)
            }
            return listJackpotModel
        }
    }
    
    struct GetProductDeal: APIRequest {
        typealias ResponseObject = [DiscountModel]
        let type: TypeDiscount!
        init(type: TypeDiscount) {
            self.type = type
        }
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["discount_type": type.rawValue]}}
        var path: String {
            get { return productDealURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> [DiscountModel] {
            var listProfuct = [DiscountModel]()
            guard let jsons = response.array else {
                return listProfuct
            }
            for json in jsons {
                let discount = DiscountModel.decodeJSON(json: json)
                listProfuct.append(discount)
            }
            return listProfuct
        }
    }
    
    struct GetProductScaned: APIRequest {
        typealias ResponseObject = [JackpotModel]
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["member_id": MemberModel.shared.idMember,
                                                 "access_token": MemberModel.shared.accessToken]}}
        var path: String {
            get { return productScanedURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> [JackpotModel] {
            var listProduct = [JackpotModel]()
            guard let jsons = response.array else {
                return listProduct
            }
            for json in jsons {
                let product = JackpotModel.decodeJSON(json: json)
                listProduct.append(product)
            }
            return listProduct
        }
    }
}
