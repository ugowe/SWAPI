//
//  String+Extensions.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation

extension String {
    
    var initalizedLetters: String {
        
        let stringArray = self.components(separatedBy: " ")
        let firstLetter = String(stringArray.first?.first ?? Character(""))
        let secondLetter = (stringArray.count > 1) ? (String(stringArray[1].first ?? Character(""))) : ""
        let initalizedLetters = "\(firstLetter.capitalized)\(secondLetter.capitalized)"
        
        return initalizedLetters
    }
    
    var localeDateString: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let currentSettingsDate = dateFormatter.date(from: self)
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy/MM/dd")
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = .current
        let updatedString = dateFormatter.string(from: currentSettingsDate ?? Date())
        
        return updatedString
    }
    
    var convertFromSnakeCase: String {
        
        let convertedString = self.replacingOccurrences(of: "_", with: " ")
        
        return convertedString.capitalized
        
    }
}
