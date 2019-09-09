//
//  Result.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

enum Result<Element, T> where T: Error {
    
    case success(Element)
    case failure(T)
    
}

