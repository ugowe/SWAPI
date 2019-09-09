//
//  CategoryInfo.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

struct CategoryInfo: Decodable {
    
    var count: Int?
    var next: String?
    var previous: String?
    var results: [GenericCategory]
}

