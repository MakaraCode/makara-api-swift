//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 23/8/20.
//

import Foundation


public enum VehicleType: String, Codable {
    case truck = "truck"
    case boat = "boat"
}


public struct Vehicle: PubliclyIdentified, Codable {
    
    public static let path = "/vehicle"

    public let publicId: String
    public let type: VehicleType
    public let maximumPassengers: Int
    public let minimumCrew: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case type
        case maximumPassengers = "maximum_passengers"
        case minimumCrew = "minimum_crew"
        case name
    }

}
