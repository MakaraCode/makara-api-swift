//
//  GearType.swift
//  
//
//  Created by Hugh Jeremy on 27/8/20.
//

import Foundation


public struct GearType: Codable, Identifiable, Hashable {
    
    public let id: Int
    public let name: String
    public let abbreviation: String
    
    internal enum CodingKeys: String, CodingKey {
        case id = "indexid"
        case name
        case abbreviation
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        if (lhs.id == rhs.id) { return true }
        return false
    }
    
    static let BouyancyControlDevice = GearType(
        id: 1, name: "Bouyancy Control Device", abbreviation: "BCD"
    )
    static let Regulator = GearType(
        id: 2, name: "Regulator", abbreviation: "REG"
    )
    
}
