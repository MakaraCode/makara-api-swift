//
//  Gear.swift
//  
//
//  Created by Hugh Jeremy on 27/8/20.
//

import Foundation


public struct Gear: PubliclyIdentified, Codable {
    
    public let publicId: String
    public let passengerId: String
    public let quantity: Int
    public let type: GearType
    public let differentiators: Array<GearDifferentiator>
    
    public static let demoGear1 = Gear(
        publicId: "demo_gear_1",
        passengerId: "demo_passenger_1",
        quantity: 1,
        type: GearType.BouyancyControlDevice,
        differentiators: [
            GearDifferentiator.demoWetsuitThickness051mm
        ]
    )

    
}
