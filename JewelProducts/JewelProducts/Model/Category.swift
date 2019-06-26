//
//  Category.swift
//  JewelProducts
//
//  Created by Apple on 26/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import SwiftyJSON


class Category : JsonDecodable{
    typealias ObjectType = Category
    
    var catName : String
    var subCategory : [Subcategory] = []
    
    required init(json : JSON) {
        
        catName = json["name"].stringValue
        subCategory = Subcategory.arrayFromJson(json["sub_category"].array)
    }
    
}

class Subcategory: JsonDecodable {
    
    typealias ObjectType = Subcategory
    
    var subCatName : String
    var description : String
    required init(json : JSON) {
        subCatName = json["name"].stringValue
        description = json["display_name"].stringValue
    }
}

