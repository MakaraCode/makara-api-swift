//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Location: Codable {
    
    let coordinates: Coordinates
    let earth3d: Earth3D
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coordinates"
        case earth3d = "earth_3d"
    }
    
}
