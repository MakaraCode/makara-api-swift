//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/7/20.
//

import Foundation


public struct SpatialReferenceFrame: Codable {
    
    let location: Location
    let distanceMetres: Int
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case distanceMetres = "distance_metres"
    }

}
