//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/11/20.
//

import Foundation


extension DiveSite {
    
    public static let demoSite1 = DiveSite(
        journalEntry: JournalEntry(
            publicId: "demo_divesite_1",
            created: Date(),
            creatingAgentId: "100"
        ),
        pointOfInterest: PointOfInterest.demo,
        description: nil,
        shopProfile: nil,
        tags: [Tag(body: "Blue", count: 4)],
        disposition: Disposition(
            sequence: 1,
            count: 1,
            limit: 1,
            offset: 0,
            order: .descending
        ),
        orderBy: .name
    )
    
}
