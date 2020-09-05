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
    public let crew: Array<CrewMember>
    public let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        
        case publicId = "public_id"
        case checkinTime = "checkin_time"
        case departureTime = "departure_time"
        case vehicle
        case site
        case passengers
        case crew
        case disposition

    }
    
    public static let demoDive1 = Dive(
        publicId: "demo_dive_1",
        checkinTime: nil,
        departureTime: nil,
        vehicle: Vehicle.demoVehicle2,
        site: DiveSite.demoSite1,
        passengers: Passenger.demoPassengers,
        crew: [CrewMember.demoCrewMember1],
        disposition:Disposition(
            sequence: 1,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending,
            orderBy: "checkin_time"
        )
    )
    
    public static let demoDive2 = Dive(
        publicId: "demo_dive_2",
        checkinTime: nil,
        departureTime: nil,
        vehicle: Vehicle.demoVehicle1,
        site: DiveSite.demoSite1,
        passengers: Passenger.demoPassengers,
        crew: [],
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending,
            orderBy: "checkin_time"
        )
    )
    
    public static let demoDives = [Dive.demoDive1, Dive.demoDive2]


}
