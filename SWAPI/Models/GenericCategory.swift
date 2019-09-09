//
//  GenericCategory.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

struct GenericCategory: Decodable {
    
    var name: String?
    var title: String?
    var openingCrawl: String?
    var birthYear: String?
    var diameter: String?
    var classification: String?
    var model: String?
    var url: String
    var created: String
    
}
