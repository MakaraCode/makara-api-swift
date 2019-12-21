//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


struct Coordinates: Codable {
    
    let longitude: String
    let latitude: String
    
    enum CodingKeys: String, CodingKey {
        case longitude = "longitude"
        case latitude = "latitude"
    }

}
