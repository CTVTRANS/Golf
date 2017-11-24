//
//  BaseModel.swift
//  Golf
//
//  Created by le kien on 11/24/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum BaseModelError: Error {
    case decodeJSONFailed
}

public protocol BaseModel {
    static func decodeJSON(json: JSON) throws -> Self
}

public extension JSON {
    func model<T: BaseModel>(_ klass: T.Type) -> T? {
        guard self.type == .dictionary, self.count > 0 else {
            return nil
        }
        do {
            return try klass.decodeJSON(json: self)
        } catch {
            debugPrint("\(klass).decodeJSON failed with error: \(error)")
            return nil
        }
    }
    
    public func modelArray<T: BaseModel>(_ klass: T.Type) -> [T]? {
        guard let jsonArray = self.array else {
            return nil
        }
        return jsonArray.flatMap { $0.model(klass) }
    }
    
    public func modelArrayValue<T: BaseModel>(_ klass: T.Type) -> [T] {
        return self.arrayValue.flatMap { $0.model(klass) }
    }
}
