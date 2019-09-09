//
//  APIError.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case invalidDataError
    case responseUnsuccessful(description: String)
    case jsonParsingError
    
    var customDescription: String {
        switch self {
        case .requestFailed(let info): return "Request Failed error: \(info)"
        case .jsonParsingError: return "JSON Parsing error"
        case .responseUnsuccessful(let info): return "Response Unsuccessful error: \(info)"
        case .invalidDataError: return "Invalid Data error"
        case .jsonConversionFailure(let info): return "JSON Conversion Failure: \(info)"
        }
    }
}
