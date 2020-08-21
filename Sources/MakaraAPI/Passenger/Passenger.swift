//
//  Passenger.swift
//  
//
//  Created by Hugh Jeremy on 21/8/20.
//

import Foundation


public struct Passenger: Codable, Identifiable, Hashable {
    
    public let human: Human
    public let diveId: String
    
    public var id: String { get { return human.publicId + diveId } }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    public static var demoPassenger1: Passenger { get {
        return Passenger(
            human: Human.demoHuman1,
            diveId: "demo_dive_1"
        )
    } }
    
    public static var demoPassenger2: Passenger { get {
        return Passenger(
            human: Human.demoHuman2,
            diveId: "demo_dive_1"
        )
    } }

    public static var demoPassengers: Array<Passenger> { get {
        return [Passenger.demoPassenger1, Passenger.demoPassenger2]
    } }
}
