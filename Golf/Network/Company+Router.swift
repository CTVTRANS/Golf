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

class CompanyGetInfo: BaseAPI {

    override func getPath() -> String { return companyInfoURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class DealProduct: BaseAPI {
    let type: TypeDiscount!
    init(typeDeal: TypeDiscount) {
        self.type = typeDeal
    }
    
    override func getPath() -> String { return dealProductURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}

class Productlist: BaseAPI {
    
    override func getPath() -> String { return produtcListURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .post}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}
