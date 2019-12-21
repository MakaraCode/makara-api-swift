//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


class MakaraDate {

    private static let dateStringFormat = "yyyy-MM-dd_HH:mm:ss.SSSSSS"

    public static func decode(apiTimeString rawTime: String) throws -> Date {

        let formatter = DateFormatter()
        formatter.dateFormat = MakaraDate.dateStringFormat
        guard let time: Date = formatter.date(from: rawTime) else {
            throw MakaraAPIError(.badResponse)
        }
        
        return time

    }
    
    public static func optionallyDecode(
        apiTimeString rawTime: String?
    ) throws -> Date? {

        if let rawTime = rawTime {
            return try MakaraDate.decode(apiTimeString: rawTime)
        }
        
        return nil

    }
    
}
