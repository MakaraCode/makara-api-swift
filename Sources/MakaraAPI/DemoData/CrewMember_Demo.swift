//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension CrewMember {
    
    public static let demoCrewMember1 = CrewMember(
        journalEntry: JournalEntry(
            publicId: "demo_crewmember_1",
            created: Date(),
            creatingAgentId: Human.demoHuman1.publicId
        ),
        role: .captain,
        teammember: Teammember.demo,
        expeditionId: Expedition.demo.publicId,
        orderBy: .name,
        active: true,
        disposition: nil
    )
    
    public static let demoCrewMember2 = CrewMember(
        journalEntry: JournalEntry(
            publicId: "demo_crewmember_2",
            created: Date(),
            creatingAgentId: Human.demoHuman1.publicId
        ),
        role: .crew,
        teammember: Teammember.demo,
        expeditionId: Expedition.demo.publicId,
        orderBy: .name,
        active: true,
        disposition: nil
    )

    public static let demoCrew = [CrewMember.demoCrewMember1]

}
