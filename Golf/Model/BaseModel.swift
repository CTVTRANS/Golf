//
//  BaseModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public enum BaseModelError: Error {
    case decodeJSONFailed
}

public protocol BaseModel {
    static func decodeJSON(json: JSON) -> Self
}
