//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


extension DateFormatter {
    
    static let nozomiTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss.SSSSSS"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
