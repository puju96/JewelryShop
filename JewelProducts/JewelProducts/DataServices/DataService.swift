//
//  DataService.swift
//  JewelProducts
//
//  Created by Apple on 26/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import SwiftyJSON


class DataService {
    
    static let instance = DataService()
    
    func loadJson() -> [Category] {

          var categories : [Category] = []
        
        if let path = Bundle.main.path(forResource: "AllMenu", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data).array
                
                for item in jsonObj! {
                    let cat = Category(json: item)
                    categories.append(cat)
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
return categories
    }
}



