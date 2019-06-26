//
//  jsonDecodable.swift
//  JewelProducts
//
//  Created by Apple on 26/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol JsonInitializable {
    
    init (json: JSON)
}

/// The objject conforming to this protocol can be instantiated by a JSON object.
protocol JsonDecodable: JsonInitializable {
    
    associatedtype ObjectType: JsonInitializable
    
    /// Creates an array of objects of this type
    ///
    /// - Parameter json: The JSON object array
    /// - Returns: Array of objects conforming to this type.
    static func arrayFromJson(_ json: [JSON]?) -> [ObjectType]
}

// MARK: - JSON parsing of array of objects
extension JsonDecodable {
    
    static func arrayFromJson(_ json: [JSON]?) -> [ObjectType] {
        var jsonObjectList: [ObjectType] = []
        
        if let jsonList = json {
            for jsonData in jsonList {
                jsonObjectList.append(ObjectType(json: jsonData))
            }
        }
        
        return jsonObjectList
    }
}

