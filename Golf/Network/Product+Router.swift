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

class ProductAll: BaseAPI {
    override func getPath() -> String { return productAllURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class ProductDeal: BaseAPI {
    
    let type: TypeDiscount!
    
    init(type: TypeDiscount) {
        self.type = type
    }
    
    override func getPath() -> String { return productDealURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class ProductScaned: BaseAPI {
    let idCard: String!
    let type: TypeJackpotProduct!
    
    init(idCard: String, type: TypeJackpotProduct) {
        self.idCard = idCard
        self.type = type
    }
    
    override func getPath() -> String { return productScanedURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}
