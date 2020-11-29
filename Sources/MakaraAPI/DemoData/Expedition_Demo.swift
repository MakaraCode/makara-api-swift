//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension Expedition {
    
    static let demo = Expedition(
        journalEntry: JournalEntry(
            publicId: "demo_expedition_1",
            created: Date(timeIntervalSinceNow: -1000),
            creatingAgentId: Human.demoHuman1.publicId
        ),
        checkinTime: Date(timeIntervalSinceNow: 500),
        checkinLocation: PointOfInterest.demo,
        departureTime: Date(timeIntervalSinceNow: 1000),
        vehicle: nil,
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
