//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Human {
    
    public static let demoHuman1 = Human(
        publicId: "demo_human_1",
        name: HumanName([
            HumanNameComponent(1, "George"),
            HumanNameComponent(2, "Washington")
        ]),
        birthDate: Date(timeIntervalSinceNow: 30*365*24*60*60),
        email: nil
    )
    
    public static let demoHuman2 = Human(
        publicId: "demo_human_2",
        name: HumanName([
            HumanNameComponent(1, "Barack"),
            HumanNameComponent(2, "Obama")
        ]),
        birthDate: Date(timeIntervalSinceNow: 34*365*24*60*60),
        email: nil
    )
    
    public static let demoHuman3 = Human(
        publicId: "demo_human_3",
        name: HumanName([
            HumanNameComponent(1, "Aaron"),
            HumanNameComponent(2, "Ralph")
        ]),
        birthDate: Date(timeIntervalSinceNow: 28*365*24*60*60),
        email: nil
    )
    
    public static let demoHumans = [
        Human.demoHuman1,
        Human.demoHuman2,
        Human.demoHuman3
    ]
    
}
