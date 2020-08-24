//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 24/8/20.
//

import Foundation


public struct Dive: Codable, PubliclyIdentified {
    
    public let publicId: String
    public let checkinTime: Date?
    public let departureTime: Date?
    public let vehicle: Vehicle?
    public let site: DiveSite?
    public let passengers: Array<Passenger>
    
    private enum CodingKeys: String, CodingKey {
        
        case publicId = "public_id"
        case checkinTime = "checkin_time"
        case departureTime = "departure_time"
        case vehicle
        case site
        case passengers
        
    }
    
    public static var demoDive1: Dive { get {
        return Dive(
            publicId: "demo_dive_1",
            checkinTime: nil,
            departureTime: nil,
            vehicle: Vehicle.demoVehicle2,
            site: DiveSite.demoSite1,
            passengers: Passenger.demoPassengers
        )
    } }
    
    public static var demoDive2: Dive { get {
        return Dive(
            publicId: "demo_dive_2",
            checkinTime: nil,
            departureTime: nil,
            vehicle: Vehicle.demoVehicle1,
            site: DiveSite.demoSite1,
            passengers: Passenger.demoPassengers
        )
    } }

}
