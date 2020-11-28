//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Location: Codable {
    
    public let coordinates: Coordinates
    public let altitude: Float
    
    enum CodingKeys: String, CodingKey {
        case coordinates
        case altitude
    }
    
}
