//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


internal class RequestData {
    
    internal static let dateStringFormat = "yyyy-MM-dd_HH:mm:ss.SSSSSS"
    
    internal let encodedData: Data
    internal let rawData: Array<Encodable>
    internal let encodedDataString: String
    
    private let dateFormatter = DateFormatter()
    private let encoder = JSONEncoder()
    
    internal init <T: Encodable>(
        data: T,
        overrideListing: Bool = false
    ) throws {
        rawData = [data]
        dateFormatter.dateFormat = RequestData.dateStringFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        if overrideListing == true {
            encodedData = try encoder.encode(data)
        } else {
            encodedData = try encoder.encode(rawData as? [T])
        }
        let dataString = String(data: encodedData, encoding: .utf8)
        guard dataString != nil else {
            throw MakaraAPIError(.inconsistentState)
        }
        encodedDataString = String(data: encodedData, encoding: .utf8)!
    }

    internal init <T: Encodable>(arrayData: Array<T>) throws {
        rawData = arrayData as Array<T>
        dateFormatter.dateFormat = RequestData.dateStringFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        encodedData = try encoder.encode(arrayData)
        let dataString = String(data: encodedData, encoding: .utf8)
        guard dataString != nil else {
            throw MakaraAPIError(.inconsistentState)
        }
        encodedDataString = dataString!
        return
    }
    
    internal func asQueryStringArgument() -> String {
        let b64data = encodedData.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
        let urlParameter = "body_data=" + b64data
        return urlParameter
    }
    
}
