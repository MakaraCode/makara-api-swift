//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Expedition {
    
    public static let demo = Expedition(
        journalEntry: JournalEntry(
            publicId: "demo_expedition_1",
            created: Date(timeIntervalSinceNow: -1000),
            creatingAgentId: Human.demoHuman1.publicId
        ),
        checkinTime: Date(timeIntervalSinceNow: 500),
        checkinLocation: PointOfInterest.demo,
        departureTime: Date(timeIntervalSinceNow: 1000),
        vehicle: nil,
        crew: [CrewMember(
            journalEntry: JournalEntry(
                publicId: "demo_crewmember_3",
                created: Date(),
                creatingAgentId: Human.demoHuman1.publicId
            ),
            role: .crew,
            teammember: Teammember.demo,
            expeditionId: "demo_expedition_1",
            orderBy: .name,
            active: true,
            disposition: nil
        )],
        shopId: Shop.demoShop.publicId,
        orderBy: .departureTime,
        disposition: Disposition(
            sequence: 1,
            count: 1,
            limit: 1,
            offset: 0,
            order: .ascending
        )
    )
    
}
