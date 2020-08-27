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


public struct Vehicle: Model {
    
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
    
    public static var demoVehicle1: Vehicle { get {
        return Vehicle(
            publicId: "demo_vehicle_1",
            type: .boat,
            maximumPassengers: 12,
            minimumCrew: 2,
            name: "Pinnacle"
        )
    } }
        
    public static var demoVehicle2: Vehicle { get {
        return Vehicle(
            publicId: "demo_vehicle_2",
            type: .truck,
            maximumPassengers: 6, minimumCrew: 1,
            name: "Ute"
        )
    } }
    
    public static var demoVehicles: Array<Vehicle> { get {
        return [Self.demoVehicle1, Self.demoVehicle2]
    } }

}
