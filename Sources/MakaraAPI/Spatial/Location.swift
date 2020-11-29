//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Location: Codable {
    
    public let coordinates: Coordinates
    public let altitude: Double
    
    enum CodingKeys: String, CodingKey {
        case coordinates
        case altitude
    }
    
    public init(
        _ coordinates: Coordinates,
        altitude: Double = 0.0
    ) {
        
        self.coordinates = coordinates
        self.altitude = altitude

        return
        
    }
    
}
