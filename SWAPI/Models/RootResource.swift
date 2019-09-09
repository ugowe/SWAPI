//
//  RootResources.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

class RootResource {
    
    enum RootResourceType: String, Comparable {
        
        case people = "people"
        case films = "films"
        case starships = "starships"
        case vehicles = "vehicles"
        case species = "species"
        case planets = "planets"
        
        private var sortOrder: Int {
            switch self {
            case .people:
                return 0
            case .films:
                return 1
            case .starships:
                return 2
            case .vehicles:
                return 3
            case .species:
                return 4
            case .planets:
                return 5
            }
        }
        
        static func < (lhs: RootResource.RootResourceType, rhs: RootResource.RootResourceType) -> Bool {
            return lhs.sortOrder < rhs.sortOrder
        }
        
    }
    
    var resourceName: String
    var resourceURL: String
    var resourceType: RootResourceType
    
    init(name: String, URL: String, type: RootResourceType){
        self.resourceName = name
        self.resourceURL = URL
        self.resourceType = type
    }
    
}


