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
    associatedtype ResponseObject
    var method: HTTPMethod {get}
    var params: [String: Any] {get}
    var path: String {get}
    func dataWithResponse(_ response: JSON) -> ResponseObject
}

extension APIRequest {
    func requestDataWith(onCompelete: @escaping BlookSuccess, onError: @escaping BlookFailure) {
        let url = URL(string: baseRUL + path)
        debugPrint(params)
        Alamofire.request(url!, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (jsonResponseData) in
            guard jsonResponseData.result.value != nil else {
                let error = jsonResponseData.result.error?.localizedDescription
                onError(error!)
                return
            }
            let json = JSON(jsonResponseData.result.value!)
            if let status = json["status_code"].int, status != 200 {
                onCompelete(status)
                return
            }
            onCompelete(self.dataWithResponse(json["data"]))
        }
    }
    
    func downloadDataWith(onCompelete: @escaping BlookSuccess, onError: @escaping BlookFailure) {
        guard let url = URL(string: path) else {
            return
        }
        let fileName = url.lastPathComponent
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url, to: destination).response { response in
            if response.error != nil {
                let error = response.error?.localizedDescription
                onError(error!)
                return
            }
            if let url = response.destinationURL {
                onCompelete(url)
            }
        }
    }
}
