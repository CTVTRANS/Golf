//
//  Hole+Router.swift
//  Golf
//
//  Created by le kien on 12/5/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension HoleModel {
    struct GetDetail: APIRequest {
        typealias ResponseObject = [HoleModel]
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["": ""]}}
        var path: String {
            get { return holeDetailURL}
            set {}
        }
        
        func dataWithResponse(_ response: JSON) -> [HoleModel] {
            var listHole = [HoleModel]()
            if let jsons = response.array {
                for json in jsons {
                    let hole = HoleModel.decodeJSON(json: json)
                    listHole.append(hole)
                }
            }
            return listHole
        }
    }
}
