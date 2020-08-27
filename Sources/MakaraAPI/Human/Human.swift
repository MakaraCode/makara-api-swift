//
//  Human.swift
//  
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation



public struct Human: Codable, PubliclyIdentified {
    
    public let publicId: String
    public let name: HumanName
    public let birthDate: Date

    private enum Keys: String, CodingKey {
        case publicId = "public_id"
        case name
        case birthDate = "birth_date"
    }
    
    public static let demoHuman1 = Human(
        publicId: "demo_human_1",
        name: HumanName([
            HumanNameComponent(1, "George"),
            HumanNameComponent(2, "Washington")
        ]),
        birthDate: Date(timeIntervalSinceNow: 30*365*24*60*60)
    )
    
    public static let demoHuman2 = Human(
        publicId: "demo_human_2",
        name: HumanName([
            HumanNameComponent(1, "Barack"),
            HumanNameComponent(2, "Obama")
        ]),
        birthDate: Date(timeIntervalSinceNow: 34*365*24*60*60)
    )
    
    public static let demoHuman3 = Human(
        publicId: "demo_human_3",
        name: HumanName([
            HumanNameComponent(1, "Aaron"),
            HumanNameComponent(2, "Ralph")
        ]),
        birthDate: Date(timeIntervalSinceNow: 28*365*24*60*60)
    )
    
    public static let demoHumans = [
        Human.demoHuman1,
        Human.demoHuman2,
        Human.demoHuman3
    ]

}
