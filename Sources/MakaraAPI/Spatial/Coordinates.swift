//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Coordinates: Codable {
    
    public let longitude: Double
    public let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "longitude"
        case latitude = "latitude"
    }
    
    public init(
        longitude: Double,
        latitude: Double
    ) {
        
        self.longitude = longitude
        self.latitude = latitude
        
        return

    }

}
