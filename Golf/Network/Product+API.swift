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

extension ProductJackpotModel {
    struct GetAll: APIRequest {
        typealias ResponseObject = [ProductJackpotModel]
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return productAllURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> [ProductJackpotModel] {
            var listJackpotModel = [ProductJackpotModel]()
            guard let jsons = response.array else {
                return listJackpotModel
            }
            for json in jsons {
                let product = ProductJackpotModel.decodeJSON(json: json)
                listJackpotModel.append(product)
            }
            return listJackpotModel
        }
    }
    
    struct GetProductDeal: APIRequest {
        typealias ResponseObject = [ProductDiscountModel]
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
        
        func dataWithResponse(_ response: JSON) -> [ProductDiscountModel] {
            var listProfuct = [ProductDiscountModel]()
            guard let jsons = response.array else {
                return listProfuct
            }
            for json in jsons {
                let discount = ProductDiscountModel.decodeJSON(json: json)
                listProfuct.append(discount)
            }
            return listProfuct
        }
    }
    
    struct GetProductScaned: APIRequest {
        typealias ResponseObject = [ProductJackpotModel]
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["member_id": MemberModel.shared.idMember,
                                                 "access_token": MemberModel.shared.accessToken]}}
        var path: String {
            get { return productScanedURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> [ProductJackpotModel] {
            var listProduct = [ProductJackpotModel]()
            guard let jsons = response.array else {
                return listProduct
            }
            for json in jsons {
                let product = ProductJackpotModel.decodeJSON(json: json)
                listProduct.append(product)
            }
            return listProduct
        }
    }
}
