//
//  Constants.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/1/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

struct Constants {
    
    struct API {
        static let baseUrlEndpoint = "https://swapi.co/api"
        static let peopleUrlEndpoint = "/api/people/"
        static let filmsUrlEndpoint = "/api/films/"
        static let starshipsUrlEndpoint = "/api/starships/"
        static let vehiclesUrlEndpoint = "/api/vehicles/"
        static let speciesUrlEndpoint = "/api/species/"
        static let planetsUrlEndpoint = "/api/planets/"
    }
    
    struct Segue {
        static let categoryVCSegue = "CategoryVCSegue"
        static let itemDetailsVCSegue = "ItemDetailsVCSegue"
    }
    
    struct Cell {
        static let rootResourceTableViewCell = "RootResourceTableViewCell"
        static let categoryTableViewCell = "CategoryTableViewCell"
        static let itemDetailsTableViewCell = "ItemDetailsTableViewCell"
    }
        

    
}

