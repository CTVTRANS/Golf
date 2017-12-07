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

extension NewsModel {
    struct GetList: APIRequest {
        let page: Int!
        init(pager: Int) {
            self.page = pager
        }
        
        var method: HTTPMethod {get { return .get}}
        var params: [String: Any] {get { return ["limit": 30, "page": page]}}
        var path: String {get { return newsListURL}}
        
        func dataWithResponse(_ response: JSON) -> Any {
            var listNews = [NewsModel]()
            for json in response["data"].arrayValue {
                let news = NewsModel.decodeJSON(json: json)
                listNews.append(news)
            }
            return listNews
        }
    }
}
