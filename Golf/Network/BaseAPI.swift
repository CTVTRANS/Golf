//
//  Router.swift
//  Golf
//
//  Created by le kien on 12/4/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias BlookSuccess = (Any) -> Void
typealias BlookFailure = (String) -> Void

protocol APIRequest {

    func requestDataWith(onCompelete: @escaping BlookSuccess, onError: @escaping BlookFailure)
    func getMethod() -> HTTPMethod
    func getParams() -> [String: Any]
    func getPath() -> String
}

protocol APIResponse {
    func dataWithResponse(_ response: JSON) -> Any
}

extension APIRequest {
    
}

class BaseAPI: APIRequest, APIResponse {
   
    func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
    
    func requestDataWith(onCompelete: @escaping BlookSuccess, onError: @escaping BlookFailure) {
        let parameter: [String: Any] = getParams()
        let method: HTTPMethod = getMethod()
        let path: String = getPath()
        let url = URL(string: baseRUL + path)

        Alamofire.request(url!, method: method, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (jsonResponseData) in
            guard jsonResponseData.result.value != nil else {
                let error = jsonResponseData.result.error?.localizedDescription
                onError(error!)
                return
            }
            let json = JSON(jsonResponseData.result.value!)
            onCompelete(self.dataWithResponse(json))
        }
    }
    
    func getMethod() -> HTTPMethod {
        return .get
    }
    
    func getParams() -> [String: Any] {
        return ["": ""]
    }
    
    func getPath() -> String {
        return ""
    }
    
}
