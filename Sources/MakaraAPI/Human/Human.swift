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
    
    public static var demoHuman1: Human { get {
        return Human(
            publicId: "demo_human_1",
            name: HumanName([
                HumanNameComponent(1, "George"),
                HumanNameComponent(2, "Washington")
            ]),
            birthDate: Date(timeIntervalSinceNow: 30*365*24*60*60)
        )
    } }
    
    public static var demoHuman2: Human { get {
        return Human(
            publicId: "demo_human_2",
            name: HumanName([
                HumanNameComponent(1, "Barack"),
                HumanNameComponent(2, "Obama")
            ]),
            birthDate: Date(timeIntervalSinceNow: 34*365*24*60*60)
        )
    } }
    
    public static var demoHumans: Array<Human> { get {
        return [Human.demoHuman1, Human.demoHuman2]
    } }

}
