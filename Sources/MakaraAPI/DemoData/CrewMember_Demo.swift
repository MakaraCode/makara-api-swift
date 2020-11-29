//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension CrewMember {
    
    public static let demoCrewMember1 = CrewMember(
        human: Human.demoHuman3,
        publicId: "demo_crewmember_1",
        expeditionId: Expedition.demo.publicId,
        orderBy: .name,
        disposition: Disposition(
            sequence: 1,
            count: 1,
            limit: 50,
            offset: 0,
            order: .ascending
        )
    )
    
    public static let demoCrew = [CrewMember.demoCrewMember1]

}
