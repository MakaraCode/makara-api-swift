//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


public struct Location: Codable {
    
    let coordinates: Coordinates
    let altitude: Float
    
    enum CodingKeys: String, CodingKey {
        case coordinates
        case altitude
    }
    
}
