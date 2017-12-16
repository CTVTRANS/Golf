//
//  Event+Router.swift
//  Golf
//
//  Created by le kien on 12/5/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension EventActivityModel {
    struct GetActivityInfo: APIRequest {
        typealias ResponseObject = EventActivityModel
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return eventInfo}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> EventActivityModel {
            let event = EventActivityModel.decodeJSON(json: response)
            return event
        }
    }
}
