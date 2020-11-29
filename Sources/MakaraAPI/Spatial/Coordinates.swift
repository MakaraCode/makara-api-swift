//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Coordinates: Codable {
    
    public let longitude: Float
    public let latitude: Float
    
    enum CodingKeys: String, CodingKey {
        case longitude = "longitude"
        case latitude = "latitude"
    }
    
    public init(
        longitude: Float,
        latitude: Float
    ) {
        
        self.longitude = longitude
        self.latitude = latitude
        
        return

    }

}
