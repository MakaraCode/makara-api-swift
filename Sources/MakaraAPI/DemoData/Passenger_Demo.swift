//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Passenger {

    public static let demoPassenger1 = Passenger(
        publicId: "demo_passenger_1",
        human: Human.demoHuman1,
        activities: [.dive, .snorkel],
        notes: [Note.demoNote],
        gear: [Gear.demoGear1],
        disposition: Disposition(
            sequence: 1,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending
        ),
        paymentOutstanding: false,
        packageId: "demo_package_1"
    )

    public static let demoPassenger2 = Passenger(
        publicId: "demo_passenger_2",
        human: Human.demoHuman2,
        activities: [.dive],
        notes: [],
        gear: [],
        disposition: Disposition(
            sequence: 2,
            count: 2,
            limit: 50,
            offset: 0,
            order: .ascending
        ),
        paymentOutstanding: false,
        packageId: "demo_package_2"
    )

    public static var demoPassengers: Array<Passenger> { get {
        return [Passenger.demoPassenger1, Passenger.demoPassenger2]
    } }
    
}
