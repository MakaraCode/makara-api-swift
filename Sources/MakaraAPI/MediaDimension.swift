//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 26/7/20.
//

import Foundation


public struct MediaDimension: Codable {
    
    let dimensionType: MediaDimensionType
    let value: Int
    
    enum CodingKeys: String, CodingKey {
        case dimensionType = "type"
        case value = "value"
    }
    
}
