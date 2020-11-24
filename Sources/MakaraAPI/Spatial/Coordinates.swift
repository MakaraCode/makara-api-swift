//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Coordinates: Codable {
    
    let longitude: Float
    let latitude: Float
    
    enum CodingKeys: String, CodingKey {
        case longitude = "longitude"
        case latitude = "latitude"
    }

}
