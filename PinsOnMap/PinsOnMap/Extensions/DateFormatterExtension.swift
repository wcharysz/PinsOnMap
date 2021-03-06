//
//  DateFormatterExtension.swift
//  PinsOnMap
//
//  Created by Wojciech Charysz on 22.04.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

extension DateFormatter {
    /**
     This is a DateFormatter based only on 4 digit year number - "yyyy".
     
     It has following configuration:
     
     - The calendar used is ISO8601,
     - The time zone is UTC,
     - The locale settings is "en_US_POSIX".
    */
    static let yyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
    
    /**
     This is a DateFormatter based only on 4 digit year number and 2 digit month number - "yyyy-MM".
     
     It has following configuration:
     
     - The calendar used is ISO8601,
     - The time zone is UTC,
     - The locale settings is "en_US_POSIX".
    */
    static let yyyyMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
}
