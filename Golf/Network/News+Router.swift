//
//  News+Router.swift
//  Golf
//
//  Created by le kien on 12/5/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewsList: BaseAPI {
    override func getPath() -> String { return newsListURL}
    override func getParams() -> [String: Any] {
        return ["": ""]
    }
    override func getMethod() -> HTTPMethod { return .get}
    override func dataWithResponse(_ response: JSON) -> Any {
        return response
    }
}
