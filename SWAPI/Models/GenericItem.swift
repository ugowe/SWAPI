//
//  GenericItem.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

class GenericItem {
    
    var itemKey: String
    var itemValue: Any
    
    init(itemKey: String, itemValue: Any) {
        self.itemKey = itemKey
        
        if let stringArray = itemValue as? [String] {
            if stringArray.count == 0 {
                self.itemValue = "N/A"
            } else {
                let stringList = stringArray.joined(separator: ",\n")
                self.itemValue = stringList
            }
        } else if itemKey == "Created" {
            self.itemValue = (itemValue as? String)?.localeDateString ?? "N/A"
        } else if itemKey == "Edited" {
            self.itemValue = (itemValue as? String)?.localeDateString ?? "N/A"
        } else if itemKey == "Episode Id" {
            self.itemValue = String(itemValue as! Int) 
        }
        else {
            self.itemValue = itemValue
        }
    }
    
}
