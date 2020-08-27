//
//  Passenger.swift
//  
//
//  Created by Hugh Jeremy on 21/8/20.
//

import Foundation


public struct Passenger: Codable, PubliclyIdentified {
    
    public let publicId: String
    public let human: Human
    public let diveId: String
    public let activities: Array<Activity>
    public let notes: Array<Note>
    public let gear: Array<Gear>
    public let disposition: Disposition
    
    public var id: String { get { return human.publicId + diveId } }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    public static let demoPassenger1 = Passenger(
        publicId: "demo_passenger_1",
        human: Human.demoHuman1,
        diveId: "demo_dive_1",
        activities: [.dive, .snorkel],
        notes: [Note.demoNote],
        gear: [Gear.demoGear1],
        disposition: Disposition(
            sequence: 1,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending
        )
    )

    public static let demoPassenger2 = Passenger(
        publicId: "demo_passenger_2",
        human: Human.demoHuman2,
        diveId: "demo_dive_1",
        activities: [.dive],
        notes: [],
        gear: [],
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending
        )
    )

    public static var demoPassengers: Array<Passenger> { get {
        return [Passenger.demoPassenger1, Passenger.demoPassenger2]
    } }
}
