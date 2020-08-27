//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 27/8/20.
//

import Foundation


public struct GearAttribute: Codable, Identifiable {
    
    public let id: Int
    public let type: GearType
    public let differentiator: GearDifferentiator

}
