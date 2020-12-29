//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Passenger {

    public static let demoPassenger1 = Passenger(
        expeditionId: "demo_expedition_1",
        human: Human.demoHuman1,
        activities: [Activity.dive],
        disposition: nil,
        orderBy: .name
    )

    public static let demoPassenger2 = Passenger(
        expeditionId: "demo_expedition_2",
        human: Human.demoHuman2,
        activities: [Activity.dive],
        disposition: nil,
        orderBy: .name
    )

    public static var demoPassengers: Array<Passenger> { get {
        return [Passenger.demoPassenger1, Passenger.demoPassenger2]
    } }

}
